{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos = {
    niri-bundle.imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      sddm-silent
      #rose-pine
    ];
    mango-bundle.imports = with flake.modules.nixos; [
      mango
      dms
      greetd
    ];
    labwc-bundle.imports = with flake.modules.nixos; [
      labwc
      dms
      sddm-silent
    ];
    xfce-bundle.imports = with flake.modules.nixos; [
      xfce
      sddm-silent
    ];
  };
}
