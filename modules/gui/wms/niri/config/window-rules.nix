{
  config,
  lib,
  ...
}: let
  inherit (config.my.modules.gui.wms) niri;
  inherit (lib) mkIf;
in {
  config = mkIf niri.enable {
    hm = _: {
      programs.niri.settings.window-rules = [
        {
          matches = [
            {
              title = "Kando Menu";
            }
          ];
          open-floating = true;
          border = {
            enable = false;
          };
          shadow = {
            enable = false;
          };
        }
        {
          matches = [
            {
              is-floating = false;
            }
          ];
          tiled-state = true;
        }
        {
          matches = [
            {
              app-id = "Wfica";
            }
          ];
          open-fullscreen = false;
          open-maximized = true;
          block-out-from = "screen-capture";
        }
        {
          matches = [
            {
              app-id = "kitty";
            }
          ];
          opacity = 0.95;
        }
      ];
    };
  };
}
