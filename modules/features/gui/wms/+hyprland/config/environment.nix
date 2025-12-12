{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        env = XCURSOR_SIZE,24
        env = HYPRCURSOR_SIZE,24
      ''
    ];
  };
}
