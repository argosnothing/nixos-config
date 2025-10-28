{
  flake.modules.nixos.xfce = {
    services = {
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
