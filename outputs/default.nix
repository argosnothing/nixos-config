{inputs, ...}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [
    ./nixos-configs.nix
    ./packages.nix
  ];

  _module.args = {
    inherit pkgs;
  };
}
