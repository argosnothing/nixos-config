{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.dwm.enable = lib.mkEnableOption "Enable User Dwm";
  };

  config = lib.mkIf (config.custom.wm.name == "dwm") {
    custom.apps = {
      dmenu.enable = true;
      st.enable = true;
    };
    home.packages = with pkgs; [
      slock
      surf
    ];
  };
}
