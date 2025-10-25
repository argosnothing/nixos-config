{
  config,
  inputs,
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
