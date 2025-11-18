{
  flake.modules.nixos.niri = {lib, ...}: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        input {
          mod-key "Super"

          keyboard {
          }

          mouse {
            accel-speed 0.3
            accel-profile "flat"
          }

          touchpad {
            dwt
            scroll-factor 0.5
          }
        }
      ''
    ];
  };
}
