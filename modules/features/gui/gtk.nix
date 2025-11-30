{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
    inherit (config.my) theme;
  in {
  };
}
