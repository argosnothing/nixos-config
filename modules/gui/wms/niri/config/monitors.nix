{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.modules) monitors;
  inherit (config.my.modules.gui.wms) niri;
  backdrop-color = config.lib.stylix.colors.withHashtag.base02;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.outputs = builtins.listToAttrs (map (monitor: {
          name = "${monitor.name}";
          value = {
            inherit (monitor) scale;
            inherit backdrop-color;
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
