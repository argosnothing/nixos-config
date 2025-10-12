{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
  inherit (config.my.modules.style.gtk) enable;
in {
  options.my.modules.style.gtk.enable = {
    enable = mkOption {
      type = bool;
      default = true;
      description = "enable Gtk overrides";
    };
  };

  config = mkIf enable {
    hm = _: {
      gtk = {
        icon-theme.package = config.my.modules.icons.package;
        icon-theme.name = config.my.modules.icons.name;
      };
    };
  };
}
