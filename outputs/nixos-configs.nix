{
  inputs,
  lib,
  ...
}: let
  defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
  inherit (inputs) nixpkgs self;
  system = "x86_64-linux";
  cfg = {
    allowUnfree = true;
    allowAliases = true;
    permittedInsecurePackages = [
      "libsoup-2.74.3"
      "libxml2-2.13.8"
    ];
  };
  pkgs = import nixpkgs {
    inherit system;
    config = cfg;
  };

  mkSystem = {
    wm ? "hyprland",
    hostname,
  }: let
    home-manager = inputs.home-manager;
    hostAttrsPath = ../hosts + "/${hostname}/attrs.nix";
    hostAttrs =
      if builtins.pathExists hostAttrsPath
      then import hostAttrsPath
      else {};
    settings = (lib.recursiveUpdate defaultSettings hostAttrs) // {inherit wm hostname;};
  in {
    nixpkgs.config.permittedInsecurePackages = [
      "libsoup-2.74.3"
    ];
    ${hostname} = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings self;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
        inputs.impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {inherit inputs settings;};
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
