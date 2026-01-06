{
  flake.modules.nixos.hyprland = {lib, ...}: {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        decoration {
            rounding = 0
            rounding_power = 2
            dim_special = 0.1

            active_opacity = 0.94
            inactive_opacity = 0.88
            fullscreen_opacity = 1.0

            shadow {
                enabled = true
                range = 4
                render_power = 3
                color = rgba(1a1a1aee)
            }

            blur {
                enabled = true
                size = 7
                passes = 2
                noise = 0.1
                xray = false
                popups_ignorealpha = 0.45
                ignore_opacity=true
                contrast = 0.95
                brightness = 0.90
                vibrancy = 1.0
            }
        }
      ''
    ];
  };
}
