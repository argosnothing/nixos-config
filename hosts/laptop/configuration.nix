{pkgs, ...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
    ./input.nix
  ];
  my = {
    modules = {
      critical.zfs.enable = true;
      misc.citrix.enable = false;
      fonts.size = 11;
      monitors = [
        {
          name = "eDP-1";
          position = {
            x = 0;
            y = 0;
          };
          dimensions = {
            width = 1920;
            height = 1080;
          };
          refresh = 60.0;
          scale = 1.0;
        }
      ];
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
