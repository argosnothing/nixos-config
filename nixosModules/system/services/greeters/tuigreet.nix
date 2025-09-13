{
  pkgs,
  config,
  lib,
  ...
}: let
in {
  options = {
    greeters.tuigreet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tuigreet as the greeter service.";
    };
    greeters.tuigreet.wm = lib.mkOption {
      type = lib.types.str;
      default = "YOU FORGOT TO SET THIS";
      description = "Register a wm to this greeter";
    };
  };
  config = lib.mkIf config.greeters.tuigreet.enable {
    custom.persist.root.cache.directories = [
      "/var/cache/tuigreet/lastuser"
    ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd ${config.greeters.tuigreet.wm}";
          user = "greeter";
        };
      };
    };
  };
}
