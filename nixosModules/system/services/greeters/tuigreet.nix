{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    greeters.tuigreet.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tuigreet as the greeter service.";
    };
  };
  config = lib.mkIf config.greeters.tuigreet.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
  };
}