{
  flake.modules.nixos.icons = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption;
    inherit (lib.types) str package;
    icon-name = config.my.icons.name;
    icon-package = config.my.icons.package;
  in {
    options.my.icons = {
      package = mkOption {
        description = "Set Icon Pack";
        type = package;
        default = pkgs.papirus-icon-theme;
      };
      name = mkOption {
        description = "Set Icon Name";
        type = str;
        default = "Papirus-Dark";
      };
    };
    config = {
      environment.variables = {
        QS_ICON_THEME = icon-name;
        XDG_ICON_THEME = icon-name;
      };
      environment.systemPackages = [
        config.my.icons.package
      ];
    };
  };
}
