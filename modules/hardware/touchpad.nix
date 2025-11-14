{
  flake.modules.nixos.touchpad = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      libinput
    ];
    services.libinput = {
      enable = true;
      touchpad = {
        accelSpeed = "1.55";
        accelProfile = "flat";
        naturalScrolling = false;
        tapping = true;
        disableWhileTyping = true;
      };
    };
  };
}
