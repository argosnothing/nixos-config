{
  flake.modules.nixos.hyprland = {
    lib,
    config,
    ...
  }: let
    inherit (config.my) cursor;
  in {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        env = XCURSOR_SIZE,${toString cursor.size}
        env = HYPRCURSOR_SIZE,${toString cursor.size}
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      ''
    ];
  };
}
