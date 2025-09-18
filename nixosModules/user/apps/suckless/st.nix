{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    custom.apps.st.enable = lib.mkEnableOption "Enable St";
  };
  config = lib.mkIf config.custom.apps.st.enable {
    home.packages = [
      (pkgs.st.overrideAttrs (_: {
        src = inputs.st;
        patches = [];
      }))
    ];
  };
}
