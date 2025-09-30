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
  config = lib.mkIf config.custom.apps.yazi.enable {
    hjem.users.${settings.username} = {
      packages = [
        pkgs.yazi
      ];
      files = {
        "./yazi".source = settings.with-config "yazi";
      };
    };
    custom.persist.home.directories = [
      ".config/yazi"
    ];
  };
}
