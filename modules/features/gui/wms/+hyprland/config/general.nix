{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        source = ~/.config/hypr/noctalia/noctalia-colors.conf
        general {
          gaps_in =  8
          gaps_out = 12
          border_size = 2
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
        }
      ''
    ];
  };
}
