# Currently unused because apparently listOf Atrribute != listOf Atrribute
# looks like i don't need to register session like this anyways so shrug
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
      # It's just lyin
      # services.xserver.displayManager = {
      #   session =
      #     map
      #     (session:
      #       {
      #         inherit (session) manage;
      #         inherit (session) name;
      #         inherit (session) start;
      #       }
      #       sessions);
      # };
    };
  };
}
