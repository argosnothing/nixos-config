{config, settings, lib, ...}: {
  options = {
    custom.system.msc.nh.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      descruption = "Enables, and configures nh for the system";
    };
  };

  config = lib.mkIf config.custom.system.msc.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 6";
      flake = "${settings.absoluteflakedir}";
    };

    home.shellAliases = {
      cleanall = "nh clean all --ask";
      rebuilds = "nh os switch --flake ${settings.absoluteflakedir}/${settings.hostname}";
      rebuildb = "nh os boot --flake ${settings.absoluteflakedir}/${settings.hostname}";
    };
  };
}
