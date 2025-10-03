{
  pkgs,
  settings,
  config,
  lib,
  ...
}: {
  options.my.modules.gui.wms.cosmic.enable = lib.mkEnableOption "Enable Cosmic";
  config = lib.mkIf config.my.modules.gui.wms.cosmic.enable {
    services = {
      desktopManager = {
        cosmic = {
          enable = true;
          xwayland.enable = true;
        };
      };
      displayManager = {
        cosmic-greeter.enable = true;
      };
    };
    my.persist.home = {
      directories = [
        ".config/cosmic"
      ];
      cache.directories = [
        ".cache/cosmic"
        ".local/share/cosmic"
      ];
    };
  };
}
