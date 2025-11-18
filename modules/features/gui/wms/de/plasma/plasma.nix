{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.plasma = {
    imports = with flake.modules.nixos; [
      cursor
      stylix
    ];

    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      desktopManager = {
        plasma6.enable = true;
      };
    };
  };
}
