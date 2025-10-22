{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
  inherit (config.my.modules.style.gtk) enable;
  icon-theme = config.my.modules.icons;
in {
  options.my.modules.style.gtk = {
    enable = mkOption {
      type = bool;
      default = true;
      description = "enable Gtk overrides";
    };
  };

  config = mkIf enable {
    hm = _: {
      gtk = {
        iconTheme.package = icon-theme.package;
        iconTheme.name = icon-theme.name;
      };
    };
  };
}
