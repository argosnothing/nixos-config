{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
in {
  options = {
    my.modules.gui.wms.niri.enable = mkOption {
      type = bool;
      default = false;
      description = "Enable xfce";
    };
  };
  config = mkIf (config.my.modules.gui.wms.name == "xfce") {
    services.xserver = {
      enable = true;
      desktopManager = {
        xfce.enable = true;
      };
      displayManager = {
        ly.enable = true;
        defaultSession = "xfce";
      };
    };
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
