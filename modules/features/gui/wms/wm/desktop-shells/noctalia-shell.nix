{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {config, ...}: {
    my = {
      desktop-shells = {
        execCommand = "noctalia-shell";
        launcherCommand = "noctalia-shell ipc call launcher toggle";
        name = "noctalia-shell";
      };
    };
    hm = {pkgs, ...}: {
      home.packages =
        [
          inputs.noctalia-shell.packages.${pkgs.system}.default
          #inputs.quickshell.packages.${pkgs.system}.default
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

      home.sessionVariables = {
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
        cache.directories = [".cache/noctalia"];
      };
    };
  };
}
