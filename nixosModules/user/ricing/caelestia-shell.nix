{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    caelestia-shell.enable = lib.mkEnableOption "Enable Caelestia shell Env";
  };

  config = lib.mkIf config.caelestia-shell.enable {
    home.packages = [inputs.caelestia-shell.packages.${pkgs.system}.default];
    programs.caelestia = {
      enable = true;
      systemd = {
        enable = false; # if you prefer starting from your compositor
        target = "graphical-session.target";
        environment = [];
      };
      settings = {
        bar.status = {
          showBattery = false;
        };
        paths.wallpaperDir = "~/Downloads/walls-catppuccin-mocha";
      };
      cli = {
        enable = true; # Also add caelestia-cli to path
        settings = {
          theme.enableGtk = false;
        };
      };
    };
    custom.persist.home = {
      directories = [".config/caelestia"];
    };
  };
}
