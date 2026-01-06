{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      "windowrule = match:title ^lazygit$, float on"
      "windowrule = monitor DP-2, match:title ^Smithay$"
    ];
  };
}
