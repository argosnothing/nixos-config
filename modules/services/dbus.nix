{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    my.modules.services.dbusConfig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable D-Bus and dconf configuration.";
    };
  };

  config = lib.mkIf config.my.modules.services.dbusConfig.enable {
    services.dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    programs.dconf = {
      enable = true;
    };
  };
}
