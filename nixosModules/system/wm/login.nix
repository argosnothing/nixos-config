{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  
  # Configure XDG portals properly to prevent crashes
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    # Don't include hyprland portal in system config to avoid conflicts
    config.common.default = "*";
  };
}