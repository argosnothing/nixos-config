{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.niri-bundle = {
    imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      sddm-silent
      rose-pine
    ];
  };
  flake.modules.nixos.mango-bundle = {
    imports = with flake.modules.nixos; [
      mango
      dms
      greetd
      rose-pine
    ];
  };
}
