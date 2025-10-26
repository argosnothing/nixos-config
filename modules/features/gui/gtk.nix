{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
  in {
    hm = {
      gtk = {
        iconTheme.package = icon-theme.package;
        iconTheme.name = icon-theme.name;
      };
    };
  };
}
