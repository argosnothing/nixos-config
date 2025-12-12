{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        monitor=,preferred,auto,auto
      ''
    ];
  };
}
