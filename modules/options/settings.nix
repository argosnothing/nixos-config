{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  # These are flake level options that NEED to be set by either a preset or a host.
  options.flake.settings = {
    gitemail = mkOption {
      description = "git email";
      default = "argosnothing@gmail.com";
      type = str;
    };
    networking.hostId = mkOption {
      description = "Host Id";
      type = str;
      default = "AB12CD34";
    };
  };
}
