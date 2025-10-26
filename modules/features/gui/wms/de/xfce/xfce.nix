{
  flake.modules.nixos.xfce = {
    services = {
      displayManager = {
        ly.enable = true;
        defaultSession = "xfce";
      };
      xserver = {
        enable = true;
        desktopManager = {
          xfce.enable = true;
        };
      };
    };
    my.persist.home.directories = [
      ".config/xfce4"
    ];
  };
}
