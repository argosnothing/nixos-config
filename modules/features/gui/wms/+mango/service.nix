{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.my.modules.gui.wms) mango;
  inherit (pkgs) system;
in {
  config =
    mkIf mango.enable {
    };
}
