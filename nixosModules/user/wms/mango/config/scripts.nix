## TODO, THIS stuff should really just be at a more top level. get on it?
{
  pkgs,
  settings,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.wms.mango.enable {
    home.packages = with pkgs; [
    ];
  };
}
