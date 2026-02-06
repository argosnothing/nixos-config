### Base Options Module
# All code executed in modules assumes these options are available, even if they don't get used.
# options.nix will be in other folders as well, and those will be scoped to the modules that needs those options
{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) listOf str attrsOf;
in {
  flake.modules.nixos.options = {
    options.my = {
      username = mkOption {
        description = "It's me!";
        type = str;
        default = "salivala";
      };
      hostname = mkOption {type = str;};
      is-vm = mkEnableOption "Is this a vm";
      is-multiple-wm = mkEnableOption "Flag to disable conflicting options for testing/experiment";
      default = {
        apps = mkOption {
          type = attrsOf str;
          default = {};
          example = {
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "inode/directory" = "thunar.desktop";
          };
          description = "MIME type to .desktop file mappings for default applications";
        };
        associations = mkOption {
          type = attrsOf (listOf str);
          default = {};
          description = "Additional applications that can handle each MIME type";
        };
      };
    };
  };
}
