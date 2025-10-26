{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  # These are flake level options that NEED to be set by either a preset or a host.
  options.flake.settings = {
    username = mkOption {
      description = "It's me!";
      type = str;
    };
    flakedir = mkOption {
      description = "Absolute path to where flake is, don't change.";
      type = str;
      default = "/home/${config.flake.settings.username}/nixos-config";
    };
    gitemail = mkOption {
      description = "git email";
      type = str;
    };
    networking.hostId = mkOption {
      description = "Host Id";
      type = str;
      default = "AB12CD34";
    };
  };
}
