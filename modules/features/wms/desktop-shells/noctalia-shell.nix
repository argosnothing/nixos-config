{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {pkgs, ...}: {
    my = {
      desktop-shells = {
        execCommand = "noctalia-shell";
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
      directories = [".config/noctalia"];
      cache.directories = [
        ".cache/noctalia"
        ".cache/quickshell"
        ".cache/wal"
      ];
    };
  };
}
