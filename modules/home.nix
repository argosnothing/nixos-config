## Configure Anything that has to do with home stuff here.
{
  lib,
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos = {
    home = {config, ...}: {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.hjem.nixosModules.default
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" flake.settings.username])
        (lib.mkAliasOptionModule ["hj"] ["hjem" "users" flake.settings.username])
      ];
      config = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          overwriteBackup = true;
          #extraSpecialArgs = {inherit self;};
          users.${flake.settings.username} = _: {
            home.stateVersion = "25.05";
            programs.home-manager.enable = true;
          };
        };
      };
    };
  };
}
