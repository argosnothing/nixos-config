{pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libinput
  ];
  services.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "-0.6";
      accelProfile = "flat";
      naturalScrolling = false;
      tapping = true;
      disableWhileTyping = true;
    };
  };
}
