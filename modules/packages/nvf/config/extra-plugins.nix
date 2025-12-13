{config, ...}: let
  inherit (config.flake) packages;
in {
  flake.modules.nvf.default = {pkgs, ...}: let
    inherit (pkgs) vimPlugins;
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    vim = {
    };
  };
}
