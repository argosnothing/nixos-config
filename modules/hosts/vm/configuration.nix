{config, ...}: {
  flake.modules.nixos.vm = {
    imports = with (config.flake.modules.nixos); [
      critical
    ];
  };
}
