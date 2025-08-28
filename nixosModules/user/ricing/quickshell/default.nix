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
  };

  config = lib.mkIf config.quickshell.enable {
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

    # Link the QuickShell configuration
   #xdg.configFile."quickshell" = {
   #  source = ./config/quickshell;
   #  recursive = true;
   #};
  };
}