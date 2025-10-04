{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.my.modules.gui.wms) mango;
  inherit (pkgs) system;
  mango-package = inputs.mango.packages.${system}.default;
in {
  config =
    mkIf mango.enable {
    };
}
