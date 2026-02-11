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
      ly
    ];
    scroll-bundle.imports = with flake.modules.nixos; [
      scroll
      noctalia-shell
      ly
    ];
    mango-bundle.imports = with flake.modules.nixos; [
      mango
      noctalia-shell
      ly
    ];
    labwc-bundle.imports = with flake.modules.nixos; [
      labwc
      dms
      sddm-silent
    ];
    oxwm-bundle.imports = with flake.modules.nixos; [
      oxwm
      ly
    ];
    xfce-bundle.imports = with flake.modules.nixos; [
      xfce
    ];
  };
}
