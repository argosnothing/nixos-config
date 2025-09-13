{
  inputs,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}: let
  defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
  inherit (inputs) nixpkgs self;
  mkSystem = {
    wm ? "hyprland",
    hostname,
  }: let
    home-manager = inputs.home-manager;
    hostAttrsPath = ../hosts + "/${hostname}/attrs.nix";
    hostAttrs = if builtins.pathExists hostAttrsPath then import hostAttrsPath else {};
    settings = (lib.recursiveUpdate defaultSettings hostAttrs) // { inherit wm hostname;};
  in {
    ${hostname} = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings pkgsUnstable self;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
        inputs.impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {inherit inputs settings pkgsUnstable;};
          home-manager.users."${settings.username}".imports = [(../hosts + "/${settings.hostname}" + /home.nix)];
        }
      ];
    };
  };
in {
  flake.nixosConfigurations =
    mkSystem {hostname = "desktop";}
    // mkSystem {hostname = "laptop";}
    // mkSystem {hostname = "p51";}
    // mkSystem {hostname = "vm";};
}
