{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf mkForce;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.animations = {
        window-open = {
          enable = true;
          kind.easing = {
            curve = "ease-out-cubic";
            "duration-ms" = 300;
          };
          custom-shader = ''
            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
              float f = niri_clamped_progress;
              vec3 t = niri_geo_to_tex * coords_geo;
              vec4 color = texture2D(niri_tex, t.st);
              float visible = step(coords_geo.y, f);
              return color * visible;
            }
          '';
        };

        window-close = {
          enable = true;
          kind.easing = {
            curve = "ease-out-cubic";
            "duration-ms" = 260;
          };
          custom-shader = ''
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
              float f = 1.0 - niri_clamped_progress;
              vec3 t = niri_geo_to_tex * coords_geo;
              vec4 color = texture2D(niri_tex, t.st);
              float visible = step(coords_geo.y, f);
              return color * visible;
            }
          '';
        };
      };
    };
  };
}
