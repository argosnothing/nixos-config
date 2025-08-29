{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    wms.cosmic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable COSMIC user configuration.";
    };
  };
  config = lib.mkIf config.wms.cosmic.enable {
    home.packages = with pkgs; [
    ];
    styles.stylix.enable = false;

    xdg.enable = true;
    xdg.mimeApps.enable = true;
  };
}
