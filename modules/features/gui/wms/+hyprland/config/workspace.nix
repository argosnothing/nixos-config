{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        workspace = r[1-9], monitor:DP-1, persistent:true
        workspace = 1, monitor:DP-1, default:true
        workspace = 10, monitor:DP-2, default:true
      ''
    ];
  };
}
