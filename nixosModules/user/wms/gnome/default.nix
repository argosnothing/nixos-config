{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    wms.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME desktop environment.";
    };
  };
  config = lib.mkIf config.wms.gnome.enable {
    # do user level gnome stuff here.
  };
}
