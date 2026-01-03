{
  flake.modules.nixos.hyprland = {
    config,
    lib,
    ...
  }: let
    inherit (config.my) monitors;

    monitorConfigs =
      map (
        monitor:
          "monitor = ${monitor.name},"
          + "${toString monitor.dimensions.width}x${toString monitor.dimensions.height}@${toString monitor.refresh},"
          + "${toString monitor.position.x}x${toString monitor.position.y},"
          + "${toString monitor.scale}"
      )
      monitors;
  in {
    my.wm.hyprland.settings = lib.mkAfter monitorConfigs;
  };
}
