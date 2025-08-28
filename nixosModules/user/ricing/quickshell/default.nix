{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    quickshell.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable QuickShell QML-based desktop shell.";
    };
    
    noctalia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Noctalia Shell - a sleek Wayland desktop shell built with QuickShell.";
    };
  };

  config = lib.mkMerge [
    # Base QuickShell configuration
    (lib.mkIf config.quickshell.enable {
      home.packages = [
        inputs.quickshell.packages.${pkgs.system}.default
      ] ++ (with pkgs; [
        # Qt core modules
        qt6.qtbase         # Core Qt functionality
        qt6.qtdeclarative  # QtQuick, QtQuick.Layouts, QtQuick.Controls
        
        # Qt additional modules
        qt6.qtsvg          # SVG image loading support
        qt6.qtimageformats # WEBP and other image formats
        qt6.qtmultimedia   # Video/audio playback
        qt6.qt5compat      # Extra visual effects (gaussian blur)
        qt6.qtwayland      # Wayland support for QuickShell
        
        # System tools needed by widgets
        networkmanager     # For nmcli commands in Network widget
        bluez             # For bluetoothctl commands in Bluetooth widget
        
        # Icon themes for widget icons
        adwaita-icon-theme        # GNOME default icons
        papirus-icon-theme        # Popular third-party icons
        networkmanagerapplet      # NetworkManager icons (nm-* icons)
        gnome-bluetooth           # Bluetooth icons
        hicolor-icon-theme        # Base icon theme
      ]);

      qt = {
        enable = true;
        platformTheme.name = lib.mkForce "gtk3";
        style.name = lib.mkForce "adwaita-dark";
      };

      # Set up environment for QML language server (qmlls)
      home.sessionVariables = {
        QML2_IMPORT_PATH = "${inputs.quickshell.packages.${pkgs.system}.default}/lib/qt-6/qml";
      };
    })

    # Noctalia Shell configuration
    (lib.mkIf config.noctalia.enable {
      # Automatically enable QuickShell when Noctalia is enabled
      quickshell.enable = true;
      
      home.packages = [
        inputs.noctalia-shell.packages.${pkgs.system}.default
      ] ++ (with pkgs; [
        # Noctalia-specific runtime dependencies
        bash
        brightnessctl      # Brightness control
        cava              # Audio visualizer
        cliphist          # Clipboard history support
        coreutils
        ddcutil           # Desktop monitor brightness
        file
        findutils
        gpu-screen-recorder # Screen recording
        libnotify         # Desktop notifications
        matugen           # Material You color generation
        swww              # Wallpaper daemon (already in your config via separate input)
        wl-clipboard      # Wayland clipboard utilities
        wlsunset          # Blue light filter for night mode
        
        # Fonts required by Noctalia
        roboto            # Default UI font
        inter             # Header font (like lock screen clock)
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
    })
  ];
}