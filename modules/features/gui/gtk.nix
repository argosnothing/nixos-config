{
  flake.modules.nixos.gtk = {config, ...}: let
    icon-theme = config.my.icons;
  in {
    hj.files = {
    };
    hm = {lib, ...}: let
      inherit (lib) mkForce;
    in {
      gtk = {
        enable = true;
        iconTheme.package = mkForce icon-theme.package;
        iconTheme.name = mkForce icon-theme.name;
      };
    };
  };
}
