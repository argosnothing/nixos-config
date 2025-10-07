{
  inputs,
  lib,
  config,
  ...
}: let
  c = config.lib.stylix.colors.withHashtag;
in {
  config = lib.mkIf (config.my.modules.gui.desktop-shells.name == "noctalia-shell") {
    my.modules.gui.desktop-shells = {
      execCommand = "noctalia-shell";
      launcherCommand = "noctalia-shell ipc call launcher toggle";
    };
    hj = {
      files = {
        ".config/noctalia/colors.json" = {
          generator = lib.generators.toJSON {};
          value = {
            mError = "${c.base08}";
            mOnError = "${c.base00}";
            mPrimary = "${c.base0F}";
            mOnPrimary = "${c.base00}";
            mSecondary = "${c.base0E}";
            mOnSecondary = "${c.base00}";
            mTertiary = "${c.base0C}";
            mOnTertiary = "${c.base00}";
            mSurface = "${c.base00}";
            mOnSurface = "${c.base05}";
            mSurfaceVariant = "${c.base01}";
            mOnSurfaceVariant = "${c.base04}";
            mOutline = "${c.base03}";
            mShadow = "#000000";
          };
        };
      };
    };
    hm = {pkgs, ...}: {
      home.packages =
        [
          inputs.noctalia-shell.packages.${pkgs.system}.default
          inputs.quickshell.packages.${pkgs.system}.default
        ]
        ++ (with pkgs; [
          kdePackages.qt5compat
          bash
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
          fontDirectories = with config.my.modules.fonts; [
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
