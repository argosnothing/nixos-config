{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (config.my) cursor;
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        cursor {
          xcursor-theme "${cursor.name}"
          xcursor-size ${cursor.size}
        }
      ''
    ];
  };
}
