{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
    inherit (config.my) theme;
  in {
    hm = {lib, ...}: let
      inherit (lib) mkForce;
    in {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme =
            if theme.polarity == "dark"
            then "prefer-dark"
            else "prefer-light";
        };
      };
      gtk = {
        enable = true;
        iconTheme.package = mkForce icon-theme.package;
        iconTheme.name = mkForce icon-theme.name;
      };
    };
  };
}
