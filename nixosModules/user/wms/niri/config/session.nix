{ ... }:

{
  # Session variables for proper Wayland/X11 integration
  home.sessionVariables = {
    XCURSOR_THEME = "Quogir";
    XCURSOR_SIZE = "24";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    ELECTRON_NO_ASAR = "1";
    ELECTRON_ENABLE_LOGGING = "0";

    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "niri";
  };
}
