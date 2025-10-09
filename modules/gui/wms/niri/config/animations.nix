{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf mkForce;
  c = config.lib.stylix.colors.withHashtag;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.animations = {
        window-open = {
          enable = true;
          kind.easing = {
            curve = "linear";
            "duration-ms" = 220;
          };
          custom-shader = ''
            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
              float p = niri_clamped_progress;
              coords_geo.y -= (1.0 - p) * 1.1;
              vec3 coords_tex = niri_geo_to_tex * coords_geo;
              vec4 color = texture2D(niri_tex, coords_tex.st);
              return color * p;
            }
          '';
        };

        window-close = {
          enable = true;
          kind.easing = {
            curve = "linear";
            "duration-ms" = 180;
          };
          custom-shader = ''
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
              float p = niri_clamped_progress;
              coords_geo.y -= p * 1.1;
              vec3 coords_tex = niri_geo_to_tex * coords_geo;
              vec4 color = texture2D(niri_tex, coords_tex.st);
              return color * (1.0 - p);
            }
          '';
        };
      };
    };
  };
}
