{
  flake.modules.nixos.wm = {lib, ...}: let
    inherit (lib) types mkOption mkEnableOption;
    inherit (types) str listOf;
  in {
    options.my.modules.gui.desktop-shells = {
      enable = mkEnableOption "Expose desktop shells option for wms to use.";
      execCommand = mkOption {
        type = str;
        description = "Command that starts the Desktop Shell";
      };
      launcherCommand = mkOption {
        type = str;
        description = "Command that starts the App Launcher";
      };
      bind = mkOption {
        type = listOf str;
        description = "Maps to bind in hyprland ( and hopefully we can use this in niri later)";
      };
      bindl = mkOption {
        type = listOf str;
        description = "Maps onto whatever bindl means in hyprland";
      };
    };
  };
}
