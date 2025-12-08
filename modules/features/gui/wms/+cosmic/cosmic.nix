{
  config,
  lib,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.cosmic = {config, ...}: {
    my.cursor.enable = lib.mkIf config.my.is-multiple-wm false;
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
