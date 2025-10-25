{
  flake.modules.nixos.niri = {config, ...}: let
    inherit (config.my.modules) monitors;
  in {
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
