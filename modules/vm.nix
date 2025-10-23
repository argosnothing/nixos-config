{inputs, ...}: let
  flake.modules.nixos.vm = {
    imports = with inputs.self.modules.nixos; [
      user
      home
      critical
    ];
    config.impermanence.enable = true;
  };
in {
  inherit flake;
}
