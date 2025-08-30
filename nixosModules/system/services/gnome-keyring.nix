{
  config,
  lib,
  ...
}: {
  options = {
    services.gnomeKeyring.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME Keyring service.";
    };
  };

  config = lib.mkIf config.services.gnomeKeyring.enable {
    services.gnome = {
      gnome-keyring.enable = true;
    };
  };
}
