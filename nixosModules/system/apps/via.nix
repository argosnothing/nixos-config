{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    via = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable VIA keyboard support.";
      };
    };
  };
  config = lib.mkIf config.via.enable {
    environment.systemPackages = with pkgs; [via];
    services.udev.extraRules = ''
      # Vial keyboard support - Telink Wireless Gaming Keyboard (Vid: 0x320F, Pid: 0x5088)
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5088", MODE="0660", GROUP="100", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
