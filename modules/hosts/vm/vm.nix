{config, ...}: let
  flake.settings.isVm = true;
  flake.modules.nixos.vm = {
    imports = with config.flake.modules.nixos; [
      base
      impermanence
      uefi
      niri
    ];
  };
in {
  inherit flake;
}
