{
  pkgs,
  lib,
  settings,
  config,
  ...
}: {
  options.custom.apps.yazi = {
    enable = lib.mkEnableOption "Enable Yazi";
  };
  config = lib.mkIf config.options.custom.apps.yazi.enable {
    hjem.users.${settings.username}.packages = [
      pkgs.yazi
    ];
  };
}
