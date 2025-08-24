{pkgs, ...}: {
  systemd.services.greetd-wallpaper = {
    description = "Wallpaper daemon for greetd session";
    wantedBy = ["graphical.target"];
    after = ["graphical.target"];
    before = ["greetd.service"];
    
    serviceConfig = {
      Type = "oneshot";
      User = "greeter";
      Group = "greeter";
      ExecStart = pkgs.writeShellScript "greetd-wallpaper-start" ''
        # Start swww daemon
        ${pkgs.swww}/bin/swww-daemon &
        sleep 2
        # Set the wallpaper
        ${pkgs.swww}/bin/swww img /home/salivala/nixos-config/media/wallpapers/animated-gif.gif
      '';
      Restart = "on-failure";
      RestartSec = "5";
    };
    
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      XDG_RUNTIME_DIR = "/run/user/994"; # greeter user UID
    };
  };
}
