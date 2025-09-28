{pkgs, ...}: {
  imports = [
    ../configuration.nix
    ./hardware-configuration.nix
  ];

  hardware.graphics.enable = true;

  services.xserver = {
    libinput.enable = true;
    libinput.touchpad = {
      accelSpeed = "0.5";
      accelProfile = "flat";
      naturalScrolling = true;
      tapping = true;
    };
  };

  environment.systemPackages = with pkgs; [
  ];
}
