{
  inputs,
  config,
  ...
}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        config.flake.overlays.citrix-pinned
      ];
      config = {
        allowUnfree = true;
      };
    };
  in {
    packages.citrix-workspace = pkgs.citrix_workspace;
  };
}
