{
  inputs,
  lib,
  ...
}: let
  inherit (builtins) mapAttrs;
  inherit (inputs) nixpkgs;
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
    pkgs = import nixpkgs {
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
      specialArgs = {
        inherit inputs settings;
      };
      modules = [
        inputs.impermanence.nixosModules.impermanence
        inputs.hjem.nixosModules.default
        inputs.stylix.nixosModules.stylix
        (../hosts + "/${hostname}/configuration.nix")
      ];
    };
in {
  # Props to https://github.com/Michael-C-Buckley/nixos/blob/master/outputs/nixosConfigurations.nix for the
  # For this idea.
  flake.nixosConfigurations = mapAttrs (hostname: params:
    mkSystem (params // {inherit hostname;})) {
    desktop = {wm = "cosmic";};
    laptop = {wm = "mango";};
    p51 = {};
    vm = {wm = "mango";};
  };
}
