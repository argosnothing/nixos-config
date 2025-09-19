{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    custom.greeters.tuigreet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tuigreet as the greeter service.";
    };
    custom.greeters.tuigreet.run-command = lib.mkOption {
      type = lib.types.enum ["Hyprland" "niri-session" "qtile start -b wayland"];
      description = "Register a wm to this greeter";
    };
  };
  config = lib.mkIf config.custom.greeters.tuigreet.enable {
    custom.persist.root.cache.directories = [
      "/var/cache/tuigreet/lastuser"
    ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${config.custom.greeters.tuigreet.run-command}";
          user = "greeter";
        };
      };
    };
  };
}
