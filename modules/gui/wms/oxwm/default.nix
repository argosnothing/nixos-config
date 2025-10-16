{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    inputs.oxwm.nixosModules.default
  ];
  options = {
    my.modules.gui.wms.oxwm.enable = mkEnableOption "Enable OXWM";
  };
  config = mkIf (config.my.modules.gui.wms.name == "oxwm") {
    my.modules.gui.wms.oxwm.enable = true;
    services = {
      xserver = {
        enable = true;
      };
      displayManager.ly.enable = true;
    };
  };
}
