{config, ...}: let
  flake.settings.username = "salivala";
  flake.modules.nixos.vm = {
    imports = with config.flake.modules.nixos; [
      base
      impermanence
    ];
  };
in {
  inherit flake;
}
