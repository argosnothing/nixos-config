{ config, lib, ... }:

{
  config = lib.mkIf config.wms.plasma.enable {
    programs.plasma.input.mice = [
      # Logitech USB Receiver
      {
        name = "Logitech USB Receiver";
        vendorId = "046d";
        productId = "c54d";
        accelerationProfile = "none";
        enable = true;
      }
      # RDR Crush 80 Mouse
      {
        name = "RDR Crush 80 Mouse";
        vendorId = "320f";
        productId = "5055";
        accelerationProfile = "none";
        enable = true;
      }
      # keyd virtual pointer
      {
        name = "keyd virtual pointer";
        vendorId = "0fac";
        productId = "1ade";
        accelerationProfile = "none";
        enable = true;
      }
    ];
  };
}
