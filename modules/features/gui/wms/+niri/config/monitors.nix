{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (config.my) monitors;
    monitorConfigs =
      map (monitor: ''
        output "${monitor.name}" {
          scale ${toString monitor.scale}
          mode "${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh}"
          position x=${toString monitor.position.x} y=${toString monitor.position.y}
        }
      '')
      monitors;
  in {
    my.wm.niri.settings = lib.mkAfter monitorConfigs;
  };
}
