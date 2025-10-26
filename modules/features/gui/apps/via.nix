{
  flake.modules.nixos.via = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [via];
    services.udev.extraRules = ''
      # Vial keyboard support - Telink Wireless Gaming Keyboard (Vid: 0x320F, Pid: 0x5088)
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5088", MODE="0660", GROUP="100", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
