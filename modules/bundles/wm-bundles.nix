{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.niri-bundle = {
    imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      sddm-silent
      #rose-pine
      catppuccin
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
  flake.modules.nixos.labwc-bundle = {
    imports = with flake.modules.nixos; [
      labwc
      dms
      sddm-silent
      catppuccin
    ];
  };
  flake.modules.nixos.xfce-bundle = {
    imports = with flake.modules.nixos; [
      xfce
      sddm-silent
      catppuccin
    ];
  };
}
