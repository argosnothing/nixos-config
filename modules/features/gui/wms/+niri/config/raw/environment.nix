{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (lib.trivial) max;
    inherit (config.my) monitors;
    max-scale = builtins.foldl' max 1.0 (map (m: m.scale) monitors);
  in {
    my.wm.niri.settings = lib.mkAfter [
      ''
        environment {
          QT_SCALE_FACTOR "${toString max-scale}"
        }
      ''
    ];
  };
}
