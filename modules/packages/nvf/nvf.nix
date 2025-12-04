# Jet Thievery
# https://github.com/Michael-C-Buckley/nixos/blob/master/modules/packages/nvf/outputs.nix
{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.modules) nvf;
in {
  perSystem = {pkgs, ...}: let
    mkNvf = modules:
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs modules;
      }).neovim;
  in {
    packages = {
      nvf = mkNvf [nvf.default];
    };
  };
}
