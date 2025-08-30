{ config, lib, ... }:

{
  config = lib.mkIf config.wms.plasma.enable {
    programs.plasma.input.mice = [
      {
        accelerationProfile = "none";  # Disables mouse acceleration (closest to "flat")
        enable = true;
      }
    ];
  };
}
