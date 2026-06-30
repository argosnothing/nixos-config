{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos = {
    niri-bundle.imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      noctalia-greeter
    ];
    xfce-bundle.imports = with flake.modules.nixos; [
      xfce
    ];
  };
}
