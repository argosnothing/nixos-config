{pkgs, ...}: {
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
  ];

  hardware.graphics.enable = true;
  services = {
    libinput.enable = true;
    libinput.touchpad = {
      accelSpeed = "0.7";
      accelProfile = "flat";
      naturalScrolling = true;
      tapping = true;
    };
  };

  environment.systemPackages = with pkgs; [
  ];
}
