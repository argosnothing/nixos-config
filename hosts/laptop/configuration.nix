{pkgs, ...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
  ];
  my = {
    modules = {
      critical.zfs.enable = true;
      misc.citrix.enable = true;
    };
    persist.enable = true;
  };

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
