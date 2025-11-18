{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    c = config.lib.stylix.colors.withHashtag;
    strut-size = 3;
    border-size = 2;
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
          }
          border {
            width ${toString border-size}
            active-color "${c.base0E}"
          }
          background-color "transparent"
        }
      ''
    ];
  };
}
