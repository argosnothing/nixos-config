{pkgs, ...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  my = {
    modules = {
      critical = {
        zfs.enable = true;
      };
      misc.citrix.enable = true;
      fonts.size = 11;
      gui = {
        wms.name = "xfce";
        steam.enable = true;
        nemo.enable = true;
        virtualization.enable = true;
        zwift.enable = true;
        audacity.enable = true;
        zed.enable = false;
        floorp.enable = true;
      };
      style = {
        gowall.enable = true;
      };
      shell = {
        spotify-player.enable = true;
        yazi.enable = true;
      };
      monitors = [
        {
          name = "DP-1";
          is-primary = true;
          dimensions = {
            width = 3840;
            height = 2160;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.2;
          refresh = 143.851;
        }
        {
          name = "DP-2";
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 3202;
            y = 402;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
    persist.enable = true;
  };

  environment.systemPackages = with pkgs; [
    uhk-agent
    cachix
    xorg.xev
    xdg-utils
  ];
  my.persist.home.directories = [".config/uhk-agent"];
  hardware.keyboard.uhk.enable = true;
  hardware.bluetooth.enable = true;

  services.udev.packages = with pkgs; [uhk-agent];
}
