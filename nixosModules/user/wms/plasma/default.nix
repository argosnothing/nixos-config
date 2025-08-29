{config, pkgs, lib, ...}: {
  options = {
    wms.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma user configuration.";
    };
  };
  config = lib.mkIf config.wms.plasma.enable {
    # stub. 
    styles.stylix.enable = false;
  };
}