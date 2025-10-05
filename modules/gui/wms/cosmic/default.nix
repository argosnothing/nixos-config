{
  pkgs,
  settings,
  config,
  lib,
  ...
}: {
  options.my.modules.gui.wms.cosmic.enable = lib.mkEnableOption "Enable Cosmic";
  config = lib.mkIf (config.my.modules.gui.wms.name == "cosmic") {
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
    my = {
      persist.root = {
        directories = [
          # "/var/lib/cosmic-greeter"
        ];
      };
      persist.home = {
        directories = [
          ".config/cosmic"
          ".config/cosmic-initial-setup-done"
        ];
        cache.directories = [
          ".cache/cosmic"
          ".cache/cosmic-settings"
          ".local/share/cosmic"
          ".local/state/cosmic"
          ".local/state/pop-launcher"
          ".local/state/cosmic-comp"
        ];
      };
    };
  };
}
