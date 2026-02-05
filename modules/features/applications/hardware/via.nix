{
  flake.modules.nixos.via = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [via];
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="320f", ATTRS{idProduct}=="5055", MODE="0660", TAG+="uaccess"
    '';
  };
}
