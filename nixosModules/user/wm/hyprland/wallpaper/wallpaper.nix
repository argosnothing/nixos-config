{pkgs, ...}: {
  imports = [
    ./wallpaper-manager.nix
  ];

  # Wallpaper systemd service that depends on graphical session
  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Restore wallpaper on session start";
      After = ["graphical-session.target" "hyprland-session.target"];
      Wants = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'wallpaper-manager current'";
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
