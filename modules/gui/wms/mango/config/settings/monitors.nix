{
  lib,
  config,
  ...
}: let
  inherit (lib) concatStringsSep;
  monitor-to-rule = m:
    builtins.concatStringsSep "" [
      "monitorrule="
      m.name
      ",0.55,1,tile,0,"
      (toString m.scale)
      ","
      (toString m.position.x)
      ","
      (toString m.position.y)
      ","
      (toString m.dimensions.width)
      ","
      (toString m.dimensions.height)
      ","
      (toString m.refresh)
    ];
in ''
  ${concatStringsSep "\n" (map monitor-to-rule config.my.modules.monitors)}
''
