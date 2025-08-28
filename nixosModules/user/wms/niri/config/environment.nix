{ ... }:

{
  programs.niri.settings.environment = {
    "NIXOS_OZONE_WL" = "1";
    "DISPLAY" = ":0";
  };
}
