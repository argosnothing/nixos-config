{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
  in {
    hm = {pkgs, ...}: {
      gtk = {
        enable = true;
        theme.name = "rose-pine";
        theme.package = pkgs.rose-pine-gtk-theme;
        iconTheme.package = icon-theme.package;
        iconTheme.name = icon-theme.name;
      };
    };
  };
}
