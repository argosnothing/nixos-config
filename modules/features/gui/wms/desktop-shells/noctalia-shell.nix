{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {
    config,
    pkgs,
    lib,
    ...
  }: let
    noctalia-shell = inputs.noctalia-shell.packages.${pkgs.system}.default;
  in {
    my = {
      desktop-shells = {
        execCommand = "noctalia-ipc";
        launcherCommand = "noctalia-shell ipc call launcher toggle";
        name = "noctalia-shell";
      };
    };
    quantum.entangle-folders = {
      "niri/.config/noctalia/colorschemes/OccultUmbral" = ".config/noctalia/colorschemes/OccultUmbral";
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
              ${lib.getExe noctalia-shell}
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
              ${lib.getExe noctalia-shell}
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
