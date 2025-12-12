{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos = {
    niri-bundle.imports = with flake.modules.nixos; [
      niri
      noctalia-shell
      cosmic-greeter
    ];
    hyprland-bundle.imports = with flake.modules.nixos; [
      hyprland
      noctalia-shell
      cosmic-greeter
    ];
    mango-bundle.imports = with flake.modules.nixos; [
      mango
      noctalia-shell
      cosmic-greeter
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
