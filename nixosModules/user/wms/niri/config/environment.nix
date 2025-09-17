{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wms.niri.enable {
    programs.niri.settings.environment = {
      "NIXOS_OZONE_WL" = "1";
      "DISPLAY" = ":0";
    };
  };
}
