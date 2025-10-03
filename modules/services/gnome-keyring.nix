{
  config,
  lib,
  ...
}: {
  options = {
    my.modules.services.gnome-keyring.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME Keyring service.";
    };
  };

  config = lib.mkIf config.my.modules.services.gnome-keyring.enable {
    services.gnome = {
      gnome-keyring.enable = true;
    };
  };
}
