{
  flake.modules.nixos.cosmic = {
    my.persist = {
      home.directories = [
        ".config/cosmic"
      ];
    };
    services = {
      displayManager.cosmic-greeter = {
        enable = true;
      };
      desktopManager.cosmic = {
        enable = true;
      };
    };
  };
}
