{...}: {
  # Wallpaper systemd service that depends on waybar
  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Restore wallpaper on session start";
      After = ["waybar.service"];
      Wants = ["waybar.service"];
      PartOf = ["graphical-session.target"];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "/home/salivala/bin/wallpaper-manager current";
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_CURRENT_DESKTOP=Hyprland"
        "XDG_SESSION_DESKTOP=Hyprland"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "XDG_SESSION_TYPE=wayland"
      ];
    };
    
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
