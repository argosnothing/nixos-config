{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.niri-bundle = {
    imports = with flake.modules.nixos; [
      niri
      dms
      sddm-silent
      rose-pine
    ];
  };
  flake.modules.nixos.mango-bundle = {
    imports = with flake.modules.nixos; [
      mango
      dms
      sddm-silent
      rose-pine
    ];
  };
}
