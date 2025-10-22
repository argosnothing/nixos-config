{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
in {
  options = {
    my.modules.gui.wms.lxqt.enable = mkOption {
      type = bool;
      default = false;
      description = "Enable lxqt";
    };
  };
  config = mkIf (config.my.modules.gui.wms.name == "lxqt") {
    services = {
      displayManager = {
        sessionPackages = with pkgs; [lxqt.lxqt-wayland-session];
      };
    };
  };
}
