{
  pkgs,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    mkNvf = extraModules:
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit (inputs) occult-theme;};
        modules =
          [../flake/packages/nvf]
          ++ extraModules;
      }).neovim;
  in {
    packages = {
      ns = pkgs.callPackage ../flake/packages/ns.nix {};
      nvf =
        mkNvf [];
    };
  };
}
