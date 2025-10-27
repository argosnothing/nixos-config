{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (config.my.theme) custom;
    inherit (lib) mkIf mkForce;
    c = config.lib.stylix.colors.withHashtag;
  in {
    hm = let
      strut-size = 0;
      border-size = 2;
    in {
      programs.niri.settings.layout = {
        gaps = 0;
        struts = {
          left = strut-size;
          right = strut-size;
          top = strut-size;
          bottom = strut-size;
        };
        focus-ring = {
          enable = false;
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
        border = {
          enable = true;
          width = border-size;
          active = mkIf custom.enable (mkForce {
            color = c.base0E;
          });
        };
      };
    };
  };
}
