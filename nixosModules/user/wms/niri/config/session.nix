{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.wms.niri.enable {
    home.pointerCursor = {
      name = "Qogir";
      package = pkgs.qogir-theme;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    # Session variables for proper Wayland/X11 integration
    home.sessionVariables = {
      XCURSOR_THEME = "Qogir";
      XCURSOR_SIZE = "24";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_NO_ASAR = "1";
      ELECTRON_ENABLE_LOGGING = "0";

      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "niri";
    };
  };
}
