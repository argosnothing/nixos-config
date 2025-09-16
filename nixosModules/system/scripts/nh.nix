{config, settings, lib, ...}: {
  options = {
    custom.system.msc.nh.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enables, and configures nh for the system";
    };
  };

  config = lib.mkIf config.custom.system.msc.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 6";
      flake = "${settings.absoluteflakedir}";
    };

    environment.shellAliases = {
      rebuildsraw = "nh os switch ${settings.absoluteflakedir}/#nixosConfigurations.${settings.hostname}";
      rebuildbraw = "nh os boot ${settings.absoluteflakedir}/#nixosConfigurations.${settings.hostname}";
    };
  };
}
