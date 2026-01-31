{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {
    config,
    pkgs,
    lib,
    ...
  }: let
    noctalia-shell = inputs.noctalia-shell.packages.${pkgs.system}.default.overrideAttrs {
      postPatch = ''
        ### Credit, Iynaix
        # don't want to add python3 to the global path
        substituteInPlace Services/Theming/TemplateProcessor.qml \
          --replace-fail "python3" "${lib.getExe pkgs.python3}"
      '';
    };
  in {
    my = {
      desktop-shells = {
        execCommand = "noctalia-ipc";
        launcherCommand = "noctalia-shell ipc call launcher toggle";
        name = "noctalia-shell";
      };
    };
    hj.files = let
      noctalia-import = "@import 'noctalia.css';";
    in {
      ".config/gtk-3.0/gtk.css".text = noctalia-import;
      ".config/gtk-4.0/gtk.css".text = noctalia-import;
    };
    environment.systemPackages =
      [
        noctalia-shell
        ### Credit, Iynaix
        (pkgs.writeShellApplication {
          name = "noctalia-ipc";
          runtimeInputs = with pkgs; [
            killall
            jq
          ];
          text = ''
            RAW_OUTPUT=$(noctalia-shell list --all --json 2>/dev/null)

            # invalid json, no instances running, so start noctalia-shell
            if [[ ! "$RAW_OUTPUT" == "["* ]]; then
              systemctl --user restart noctalia-shell
              exit
            fi

            NOCTALIA_PATH=$(noctalia-shell list --all --json | jq -r '.[] | .config_path | sub("/share/noctalia-shell/shell.qml$"; "")')

            # using dev version, don't kill the shell
            if [[ "$NOCTALIA_PATH" =~ "_dirty" ]]; then
              "$NOCTALIA_PATH/bin/noctalia-shell" ipc call "$@"
              exit
            fi

            # different instance, kill previous instances
            if [[ ! "$NOCTALIA_PATH" =~ "${noctalia-shell}" ]]; then
              killall .quickshell-wrapper
              systemctl --user restart noctalia-shell
              sleep 2
            fi

            ${lib.getExe noctalia-shell} ipc call "$@"
          '';
        })
      ]
      ++ (with pkgs; [
        kdePackages.qt5compat
        brightnessctl
        cava
        cliphist
        coreutils
        ddcutil
        file
        findutils
        gpu-screen-recorder
        libnotify
        matugen
        swww
        wl-clipboard
        wlsunset
        roboto
        inter
        material-symbols
      ]);

    environment.variables = {
      FONTCONFIG_FILE = "${pkgs.makeFontsConf {
        fontDirectories = with config.my.fonts; [
          sans.package
          serif.package
          pkgs.material-symbols
        ];
      }}";
    };

    # Systemd service for noctalia-shell
    systemd.user.services.noctalia-shell = {
      description = "Noctalia Shell - Wayland desktop shell";
      documentation = ["https://docs.noctalia.dev/docs"];
      partOf = ["graphical-session.target"];
      restartTriggers = [noctalia-shell];

      environment = {
        PATH = lib.mkForce "/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QS_ICON_THEME = config.my.icons.name;
        XCURSOR_THEME = config.my.cursor.name;
        XCURSOR_SIZE = toString config.my.cursor.size;
        XCURSOR_PATH = "${config.my.cursor.package}/share/icons";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        NIXOS_OZONE_WL = "1";
        ELECTRON_ENABLE_LOGGING = "0";
      };

      serviceConfig = {
        ExecStart = lib.getExe noctalia-shell;
        Restart = "on-failure";
        KillMode = "process";
      };
    };

    # start after WM initializes
    my.startup-services = ["noctalia-shell.service"];

    my.persist.home = {
      directories = [".config/noctalia"];
      cache.directories = [
        ".cache/noctalia"
        ".cache/quickshell"
        ".cache/wal"
      ];
    };
  };
}
