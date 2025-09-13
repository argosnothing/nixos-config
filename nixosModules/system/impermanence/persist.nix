{ lib, config, ... }:

let
  enabled = config.custom.persist.enable or false;
in
{
  # no new options; we just extend existing ones
  config = lib.mkIf enabled {

    # Persist (snapshotted/backed up)
    custom.persist.home.directories = lib.mkAfter [
      ".config/sops"
      ".ssh"
      ".mozilla/firefox"
      ".config/discord"
      ".config/vesktop"
      ".config/Vencord"
    ];

    # Cache (persisted but not snapshotted/backed up)
    custom.persist.home.cache.directories = lib.mkAfter [
      ".cache/mozilla"
      ".config/discord/Cache"
      ".config/vesktop/Cache"
    ];

    # If you want system-level extras, uncomment and extend:
    # custom.persist.root.directories = lib.mkAfter [ ];
    # custom.persist.root.files       = lib.mkAfter [ ];
    # custom.persist.root.cache.directories = lib.mkAfter [ ];
    # custom.persist.root.cache.files       = lib.mkAfter [ ];
  };
}

