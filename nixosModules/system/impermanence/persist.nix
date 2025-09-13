{ lib, config, ... }:

let
  enabled = config.custom.persist.enable or false;
in
{
  config = lib.mkIf enabled {
    custom.persist.home.directories = lib.mkAfter [
      ".config/sops"
      ".ssh"
      ".mozilla/firefox"
      ".config/discord"
      ".config/vesktop"
      ".config/Vencord"
      "nixos-config"
    ];
  };
}

