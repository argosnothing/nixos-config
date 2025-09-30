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
    inherit (inputs) home-manager;
    pkg-config = {
      allowUnfree = true;
      allowAliases = true;
      permittedInsecurePackages = ["libsoup-2.74.3" "libxml2-2.13.8"];
    };
    pkgs = import nixpkgs {
      inherit system;
      config = pkg-config;
    };
    # I hate citrix I hate citrix, etc.
    pkgsStable = import nixpkgs-stable {
      inherit system;
      config = pkg-config;
    };

    # Default Settings has the parent settings, hosts/xyz/attrs.nix
    # boot.firmware needs to be set to either grub or uefi in attrs.nix
    defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
    hostAttrsPath = ../hosts + "/${hostname}/attrs.nix";
    hostAttrs =
      if builtins.pathExists hostAttrsPath
      then import hostAttrsPath
      else {};
    settings = (lib.recursiveUpdate defaultSettings hostAttrs) // {inherit wm hostname;};
  in
    nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit inputs settings pkgsStable;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
        inputs.impermanence.nixosModules.impermanence
        inputs.hjem.nixosModules.default
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
in {
  # Props to https://github.com/Michael-C-Buckley/nixos/blob/master/outputs/nixosConfigurations.nix for the
  # For this idea.
  flake.nixosConfigurations = mapAttrs (hostname: params:
    mkSystem (params // {inherit hostname;})) {
    desktop = {wm = "mango";};
    laptop = {wm = "mango";};
    p51 = {};
    vm = {wm = "gnome";};
  };
}
