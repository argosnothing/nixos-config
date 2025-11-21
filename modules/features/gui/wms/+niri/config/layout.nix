{
  flake.modules.nixos.niri = {
    lib,
    config,
    ...
  }: let
    strut-size = 3;
    border-size = 2;
    inherit (config.my) theme;
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        layout {
          gaps ${toString 4}
          struts {
            left ${toString strut-size}
            right ${toString strut-size}
            top ${toString strut-size}
            bottom ${toString strut-size}
          }
          focus-ring {
            off
            active-color "${theme.accent}"
          }
          border {
            width ${toString border-size}
            active-color "${theme.accent}"
          }
          background-color "transparent"
        }
      ''
    ];
  };
}
