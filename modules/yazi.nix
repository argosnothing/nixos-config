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
      xdg.config.files = {
        "yazi/keymap.toml".source = ../.config/yazi/keymap.toml;
      };
    };
    custom.persist.home.directories = [
      ".config/yazi"
    ];
  };
}
