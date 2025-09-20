{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  options = {
    custom.apps.wmenu.enable = lib.mkEnableOption "Enable wmenu";
  };
  config = lib.mkIf config.custom.apps.wmenu.enable {
    home.packages = [
      (pkgs.wmenu.overrideAttrs (_: {
        src = inputs.wmenu;
        patches = [];
      }))
    ];
  };
}
