{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos = {
    niri-bundle.imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      sddm-silent
      #rose-pine
      catppuccin
    ];
    mango-bundle.imports = with flake.modules.nixos; [
      mango
      dms
      greetd
      catppuccin
    ];
    labwc-bundle.imports = with flake.modules.nixos; [
      labwc
      dms
      sddm-silent
      catppuccin
    ];
    xfce-bundle.imports = with flake.modules.nixos; [
      xfce
      sddm-silent
      catppuccin
    ];
  };
}
