{
  lib,
  config,
  ...
}: let
  enabled = config.my.persist.enable or false;
in {
  config = lib.mkIf enabled {
    my.persist.home.directories = lib.mkAfter [
      ".local/share/direnv"
      ".config/yazi"
      ".config/sops"
      ".ssh"
      "nixos-config"
    ];
  };
}
