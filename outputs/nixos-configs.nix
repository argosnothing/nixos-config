{
  inputs,
  lib,
  pkgs,
  pkgsStable,
  ...
}: let
  mkSystem = {
    wm ? "hyprland",
    hostname,
  }: let
    defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
    inherit (inputs) home-manager;
    hostAttrsPath = ../hosts + "/${hostname}/attrs.nix";
    hostAttrs =
      if builtins.pathExists hostAttrsPath
      then import hostAttrsPath
      else {};
    settings = (lib.recursiveUpdate defaultSettings hostAttrs) // {inherit wm hostname;};
  in {
    ${hostname} = pkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings pkgsStable;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
        inputs.impermanence.nixosModules.impermanence
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            extraSpecialArgs = {inherit inputs settings pkgsStable;};
            users."${settings.username}" = {
              imports = [
                inputs.stylix.homeModules.stylix
                (../hosts + "/${settings.hostname}" + /home.nix)
              ];
            };
          };
        }
      ];
    };
  };
in {
  flake.nixosConfigurations =
    mkSystem {
      hostname = "desktop";
    }
    // mkSystem {
      hostname = "laptop";
    }
    // mkSystem {hostname = "p51";}
    // mkSystem {hostname = "vm";};
}
