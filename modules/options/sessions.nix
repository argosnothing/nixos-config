# Window Managers and desktop environments can register stuff here
# This is currently unused, but in the future could be useful if i want to
# generate a display manager menu or something explicitly.
{
  flake.modules.nixos.options = {lib, ...}: let
    inherit (lib) types mkOption;
    inherit (types) enum listOf str submodule package nullOr;
  in {
    options = {
      my = {
        session = mkOption {
          type = submodule {
            options = {
              name = mkOption {
                type = str;
              };
              exec-command = mkOption {
                type = str;
              };
            };
          };
        };
        # If I ever want to support simultaneous sessions in the future.
        sessions = mkOption {
          description = "Registered desktop and window manager info";
          default = [{}];
          type = listOf (submodule {
            options = {
              manage = enum ["desktop" "window"];
              name = mkOption {
                type = str;
              };
              start = mkOption {
                description = "startup command for the session";
                type = str;
              };
              package = mkOption {
                description = "session package";
                type = nullOr package;
              };
            };
          });
        };
        startup-services = lib.mkOption {
          description = "Services to start after the WM is initialized";
          type = lib.types.listOf lib.types.str;
          default = [];
        };
      };
    };
  };
}
