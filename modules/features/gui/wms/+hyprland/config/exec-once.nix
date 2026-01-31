{
  flake.modules.nixos.hyprland = {
    lib,
    pkgs,
    ...
  }: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        exec-once = ${lib.getExe' pkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart hyprland-session.target
        exec-once = ${lib.getExe pkgs.xorg.xrdb} -merge ~/.Xresources
      ''
    ];
  };
}
