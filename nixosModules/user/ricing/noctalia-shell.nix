{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    noctalia-shell.enable = lib.mkEnableOption "Enable Noctalia Shell Env";
  };

  config = lib.mkIf config.noctalia-shell.enable {
    home.packages =
      [
        inputs.noctalia-shell.packages.${pkgs.system}.default
      ]
      ++ (with pkgs; [
        # Noctalia-specific runtime dependencies
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

        # Fonts required by Noctalia
        roboto
        inter
        material-symbols # Icon font for UI elements
      ]);

    # Enhanced session variables for Noctalia
    home.sessionVariables = {
      # Ensure Noctalia can find its configuration
      NOCTALIA_CONFIG_DIR = "${config.xdg.configHome}/noctalia";
      NOCTALIA_CACHE_DIR = "${config.xdg.cacheHome}/noctalia";

      # Font configuration for proper rendering
      FONTCONFIG_FILE = "${pkgs.makeFontsConf {
        fontDirectories = [
          pkgs.material-symbols
          pkgs.roboto
          pkgs.inter
        ];
      }}";
    };
    # Create Noctalia configuration directory
    xdg.configFile."noctalia/.keep".text = "";
    xdg.cacheFile."noctalia/images/.keep".text = "";

    custom.persist.home = {
      files = lib.mkAfter [
        ".config/noctaliasettings.json"
        ".config/noctaliacolors.json"
      ];
      cache = {
        directories = lib.mkAfter [
          ".cache/noctaliaimages"
        ];
        files = lib.mkAfter [
          ".cache/noctalianotifications.json"
          ".cache/noctalialocation.json"
        ];
      };
    };
  };
}
