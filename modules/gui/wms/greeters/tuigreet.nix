{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    my.modules.gui.wms.greeters.tuigreet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tuigreet as the greeter service.";
    };
    my.modules.gui.wms.greeters.tuigreet.run-command = lib.mkOption {
      type = lib.types.enum ["Hyprland" "niri-session" "qtiler" "dwl" "dwlwbar"];
      description = "Register a wm to this greeter";
    };
  };
  config = lib.mkIf config.my.modules.gui.wms.greeters.tuigreet.enable {
    my.persist.root.cache.directories = [
      "/var/cache/tuigreet/lastuser"
    ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${config.my.modules.gui.wms.greeters.tuigreet.run-command}";
          user = "greeter";
        };
      };
    };
  };
}
