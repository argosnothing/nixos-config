{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.base = {pkgs, ...}: {
    specialisation = {
      niri.configuration = {
        imports = with flake.modules.nixos; [
          niri
          noctalia-shell
          ly
        ];
      };
      hyprland.configuration = {
        imports = with flake.modules.nixos; [
          hyprland
          noctalia-shell
          ly
        ];
      };
    };
  };
}
