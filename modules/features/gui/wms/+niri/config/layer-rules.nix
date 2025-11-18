{
  flake.modules.nixos.niri = {lib, ...}: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        layer-rule {
          match namespace="^noctalia-wallpaper*"
          place-within-backdrop true
        }

        layer-rule {
          match namespace="^quickshell$"
          place-within-backdrop true
        }

        layer-rule {
          match namespace="^noctalia-overview$"
          opacity 0.0
        }
      ''
    ];
  };
}
