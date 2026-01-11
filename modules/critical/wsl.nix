{
  inputs,
  config,
  ...
}: {
  flake.modules.nixos.windows = {pkgs, ...}: {
    imports = [
      inputs.nixos-wsl.nixosModules.default
    ];

    wsl.enable = true;
    wsl.defaultUser = "nixos";
    wsl.startMenuLaunchers = true;
  };
}
