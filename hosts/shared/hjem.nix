{
  pkgs,
  settings,
  lib,
  ...
}: {
  hjem.users.${settings.username} = {
    enable = true;
    directory = "/home/${settings.username}";
    files = {
    };
  };
}
