{
  inputs,
  lib,
  settings,
  config,
  ...
}: {
 imports = [
    #inputs.caelestia-shell.homeManagerModules.default
 ];
  config = lib.mkIf (config.custom.desktop-shell.name == "caelestia-shell") {
    custom.desktop-shell = {
      execCommand = "caelestia-shell";
      launcherCommand = "caelestia-shell ipc call drawers toggle launcher";
    };
    home.packages = [inputs.caelestia-shell.packages."${settings.system}".with-cli];
   #programs.caelestia = {
   #  enable = true;
   #  systemd = {
   #    enable = false; # if you prefer starting from your compositor
   #    target = "graphical-session.target";
   #    environment = [];
   #  };
   #  settings = {
   #    bar.status = {
   #      showBattery = false;
   #    };
   #    dashboard = {
   #      enable = true;
   #    };
   #    launcher = {
   #      enable = true;
   #    };
   #    paths.wallpaperDir = "~/Downloads/walls-catppuccin-mocha";
   #  };
   #  cli = {
   #    enable = true; # Also add caelestia-cli to path
   #    settings = {
   #      theme.enableGtk = true;
   #    };
   #  };
   #};
    custom.persist.home = {
      directories = [".config/caelestia"];
      cache.directories = [".cache/caelestia"];
    };
  };
}
