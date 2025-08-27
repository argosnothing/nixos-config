{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [];
  options = {
    wms.niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri Wayland compositor.";
    };
  };
  config = lib.mkIf config.wms.niri.enable {
    programs.niri = {
      enable = true;
    };
  };
}