{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.modules) monitors;
  inherit (config.my.modules.gui.wms) niri;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.outputs = builtins.listToAttrs (map (monitor: {
          name = "${monitor.name}";
          value = {
            inherit (monitor) scale;
            mode = {
              inherit (monitor) refresh;
              inherit (monitor.dimensions) width height;
            };
            position = {
              inherit (monitor.position) x y;
            };
          };
        })
        monitors);
    };
  };
}
