{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
in {
  options = {
    my.modules.gui.wms.xfce.enable = mkOption {
      type = bool;
      default = false;
      description = "Enable xfce";
    };
  };
  config = mkIf (config.my.modules.gui.wms.name == "xfce") {
    my.modules = {
      gui.wms = {
        cursor.enable = true;
        xfce.enable = true;
      };
    };
    services = {
      displayManager = {
        ly.enable = true;
        defaultSession = "xfce";
      };
      xserver = {
        enable = true;
        desktopManager = {
          xfce.enable = true;
        };
      };
    };
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
