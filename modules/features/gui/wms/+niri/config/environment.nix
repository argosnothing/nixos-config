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
    hm.programs.niri.settings.environment = {
      QT_SCALE_FACTOR = toString max-scale;
    };
  };
}
