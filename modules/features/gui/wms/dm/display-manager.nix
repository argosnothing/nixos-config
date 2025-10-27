{
  flake.modules.nixos.display-manager = {
    lib,
    config,
    ...
  }: let
    inherit (lib) types;
    inherit (builtins) map;
    inherit (config.my) sessions;
  in {
    options = {
    };
    config = {
      services.xserver.displayManager = {
        enable = true;
        session = map (session:
          {
            inherit (session) manage;
            inherit (session) name;
            inherit (session) start;
          }
          sessions);
      };
    };
  };
}
