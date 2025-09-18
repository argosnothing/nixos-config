{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  options = {
    custom.apps.dmenu.enable = lib.mkEnableOption "Enable Dmenu";
  };
  config = lib.mkIf config.custom.apps.dmenu.enable {
    home.packages = [
      (pkgs.dmenu.overrideAttrs (_: {
        src = inputs.suckless.dmenu;
        patches = [];
      }))
    ];
  };
}
