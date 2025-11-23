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
          gaps ${toString 7}
          struts {
            left ${toString strut-size}
            right ${toString strut-size}
            top ${toString strut-size}
            bottom ${toString strut-size}
          }
          focus-ring {
            on
            active-color "${theme.accent}"
            width 2
          }
          border {
            width ${toString border-size}
            active-color "${theme.accent}"
            inactive-color "${theme.inactive}"
          }
          background-color "transparent"
        }
      ''
    ];
  };
}
