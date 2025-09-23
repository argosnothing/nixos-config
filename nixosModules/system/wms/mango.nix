{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.mango.nixosModules.mango];
  options = {
    wms.mango.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mango WC as the window managerk";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    wms.mango.enable = true;
    styles.stylix.enable = true;
    programs.mango.enable = true;
  };
}
