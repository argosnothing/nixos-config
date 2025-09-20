{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.dwl.enable = lib.mkEnableOption "Enable User DWL";
  };
  config = lib.mkIf (config.custom.wm.name == "dwl") {
    styles.stylix.enable = true;
    home.packages = with pkgs; [
    ];
  };
}
