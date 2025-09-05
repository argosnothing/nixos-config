{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  noctalia.enable = lib.mkEnableOption "Enable Noctalia Shell Env";

  config = lib.mkIf config.noctalia.enable {
      # Automatically enable QuickShell when Noctalia is enabled
      quickshell.enable = true;
      
      home.packages = [
        inputs.noctalia-shell.packages.${pkgs.system}.default
      ] ++ (with pkgs; [
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
        material-symbols  # Icon font for UI elements
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
    };
}
