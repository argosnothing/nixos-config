{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
  in {
    hm = {
      pkgs,
      lib,
      ...
    }: let
      inherit (lib) mkForce;
    in {
      gtk = {
        enable = true;
        theme.name = mkForce "rose-pine";
        theme.package = mkForce pkgs.rose-pine-gtk-theme;
        iconTheme.package = mkForce icon-theme.package;
        iconTheme.name = mkForce icon-theme.name;
      };
    };
  };
}
