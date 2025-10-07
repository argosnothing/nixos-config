{
  pkgs,
  settings,
  config,
  lib,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in {
  options = {
    my.modules.gui.wms.greeters.tuigreet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tuigreet as the greeter service.";
    };
    my.modules.gui.wms.greeters.tuigreet.command = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.my.modules.gui.wms.greeters.tuigreet.enable {
    my.persist.root.cache.directories = [
      "/var/cache/tuigreet/lastuser"
    ];
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${tuigreet} --user-menu -t -r --cmd '${config.my.modules.gui.wms.greeters.tuigreet.command}'";
          user = "greeter";
        };
      };
    };
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
