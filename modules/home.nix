{
  lib,
  inputs,
  ...
}: {
  flake.modules.nixos = {
    home = {config, ...}: {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" config.user.name])
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        overwriteBackup = true;
        #extraSpecialArgs = {inherit self;};
        users.${config.user.name} = _: {
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        };
      };
    };
  };
}
