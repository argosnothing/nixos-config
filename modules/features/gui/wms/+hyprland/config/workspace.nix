
{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        workspace = r[1-9]s[false], monitor:name:DP-1
      ''
    ];
  };
}
