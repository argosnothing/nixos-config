{inputs, ...}: {
  flake.modules.nixos.noctalia-shell = {config, ...}: {
    my = {
      desktop-shells = {
        execCommand = "noctalia-shell";
        launcherCommand = "noctalia-shell ipc call launcher toggle";
        name = "noctalia-shell";
      };
    };
    #hj.files.".config/noctalia/colors.json".text = ''
    #  {
    #    "mError": "#FF5B61",
    #    "mOnError": "#152326",
    #    "mOnPrimary": "#152326",
    #    "mOnSecondary": "#152326",
    #    "mOnSurface": "#DBD0C6",
    #    "mOnSurfaceVariant": "#91A4AD",
    #    "mOnTertiary": "#DBD0C6",
    #    "mOutline": "#568270",
    #    "mPrimary": "#A7CBEA",
    #    "mSecondary": "#9DC6A9",
    #    "mShadow": "#152326",
    #    "mSurface": "#152326",
    #    "mSurfaceVariant": "#38524F",
    #    "mTertiary": "#D59CCE"
    #  }
    #'';
    hm = {pkgs, ...}: {
      home.packages =
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
