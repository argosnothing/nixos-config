{
  pkgs,
  lib,
  settings,
  config,
  ...
}: let
in {
  options.my.modules.shell.yazi = {
    enable = lib.mkEnableOption "Enable Yazi";
  };
  config = lib.mkIf config.my.modules.shell.yazi.enable {
    hjem.users.${settings.username} = {
      packages = [
        pkgs.yazi
      ];
      xdg.config.files = {
        "yazi/keymap.toml" = {
          source = .config/yazi/keymap.toml;
        };
      };
    };
    my.persist.home.directories = [
      ".config/yazi"
      ".local/state/yazi"
    ];
  };
}
