{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {pkgs, ...}: {
    systemd.user.services.niri-overview-bar = {
      description = "Sync noctalia bar visibility with niri overview state";
      wantedBy = ["niri-session.target"];
      after = ["niri-session.target"];
      serviceConfig = {
        Environment = "PATH=/run/current-system/sw/bin";
        ExecStart = pkgs.writeShellScript "niri-overview-bar" ''
          sleep 2
          if niri msg overview-state | grep -q "open"; then
            noctalia msg bar-show
          else
            noctalia msg bar-hide
          fi
          niri msg event-stream | while IFS= read -r line; do
            case "$line" in
              "Overview toggled: true")  noctalia msg bar-show ;;
              "Overview toggled: false") noctalia msg bar-hide ;;
            esac
          done
        '';
        Restart = "on-failure";
        RestartSec = "2s";
      };
    };
    my = {
      desktop-shells = {
        execCommand = "noctalia";
        launcherCommand = "noctalia msg panel-open launcher";
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
        inputs.noctalia-shell.packages.${pkgs.system}.default
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

    my.persist.home = {
      directories = [
        ".config/noctalia"
        ".local/state/noctalia"
      ];
      cache.directories = [
        ".cache/noctalia"
        ".cache/quickshell"
        ".cache/wal"
      ];
    };
  };
}
