{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.cosmic = {
    imports = with flake.modules.nixos; [
      cursor
    ];
    my.cursor.enable = false;
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
