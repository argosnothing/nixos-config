# This is a base preset, that defines the things i need to have for a functional nixos system.
# Not counting for wms
{config, ...}: {
  flake.modules.nixos.base = {
    imports = with config.flake.modules.nixos; [
      user
      fonts
      home
      critical
    ];
  };
}
