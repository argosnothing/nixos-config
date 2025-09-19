{
  inputs,
  lib,
  ...
}: let
  inherit (builtins) mapAttrs;
  inherit (inputs) self nixpkgs nixpkgs-stable;
  mkSystem = {
    wm ? "hyprland",
    hostname,
    system ? "x86_64-linux",
  }: let
    pkg-config = {
      allowUnfree = true;
      allowAliases = true;
      permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
    };
    defaultSettings = import ./defaultSettings.nix {};
    inherit (inputs) home-manager;
    hostAttrsPath = ../hosts + "/${hostname}/attrs.nix";
    hostAttrs =
      if builtins.pathExists hostAttrsPath
      then import hostAttrsPath
      else {};
    settings = (lib.recursiveUpdate defaultSettings hostAttrs) // {inherit wm hostname;};
  in
    nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = {
        inherit system;
        config = pkg-config;
      };
      pkgsStable = {
        inherit system;
        config = pkg-config;
      };
      specialArgs = {inherit inputs settings;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
        inputs.impermanence.nixosModules.impermanence
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            extraSpecialArgs = {inherit inputs settings;};
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
in {
  flake.nixosConfigurations = mapAttrs (hostname: params:
    mkSystem (params // {inherit hostname;})) {
    desktop = {};
    laptop = {};
    p51 = {};
    vm = {};
  };
}
