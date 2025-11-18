{
  flake.modules.nixos.niri = {lib, ...}: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        input {
          focus-follows-mouse off
          warp-mouse-to-focus off
          
          keyboard {
            mod-key "Super"
            mod-key-nested "Super"
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
