{
  config,
  lib,
  ...
}: {
  flake.modules.nixos = let
    username = config.user.name;
  in {
    home = {
      inputs,
      ...
    }: {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
      ];
    };
  };
}
