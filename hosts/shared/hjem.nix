{
  pkgs,
  settings,
  lib,
  ...
}: {
  hjem.users.${settings.username} = {
    directory = "/home/${settings.username}";
    files = {
      ".config/foo".text = "bar";
    };
  };
}
