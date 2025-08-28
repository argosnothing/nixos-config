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
      qt6.qtsvg          # SVG image loading support
      qt6.qtimageformats # WEBP and other image formats
      qt6.qtmultimedia   # Video/audio playback
      qt6.qt5compat      # Extra visual effects (gaussian blur)
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
  };
}