{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.modules.misc.battery) enable;
in {
  options.my.modules.misc.battery = {
    enable = mkEnableOption "Enable Battery management";
  };
  config = mkIf enable {
    powerManagement.powertop.enable = true;
    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
