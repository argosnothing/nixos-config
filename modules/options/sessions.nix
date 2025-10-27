# Window Managers and desktop environments can register stuff here
{
  flake.modules.nixos.options = {lib, ...}: let
    inherit (lib) types mkOption;
    inherit (types) listOf str submodule;
  in {
    options = {
      my.sessions = mkOption {
        description = "Registered desktop and window manager info";
        default = [{}];
        type = listOf (submodule {
          options = {
            name = mkOption {
              type = str;
            };
            startup-command = mkOption {
              description = "startup command for the session";
              type = str;
            };
          };
        });
      };
    };
  };
}
