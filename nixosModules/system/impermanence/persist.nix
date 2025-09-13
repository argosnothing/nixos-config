{ lib, config, ... }:

let
  enabled = config.custom.persist.enable or false;
in
{
  config = lib.mkIf enabled {
    environment.persistence."/persist".directories = [
      "/var/lib/greetd"
    ];
    custom.persist.home.directories = lib.mkAfter [
      ".config/sops"
      ".ssh"
      ".mozilla/firefox"
      ".config/discord"
      ".config/vesktop"
      ".config/Vencord"
      "nixos-config"
    ];

    custom.persist.home.cache.directories = lib.mkAfter [
      ".cache/mozilla"
      ".config/discord/Cache"
      ".config/vesktop/Cache"
    ];
  };
}

