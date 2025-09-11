{
  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [./outputs];
      perSystem = {system, ...}: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      };
    };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-compat.url = "github:edolstra/flake-compat";
    systems.url = "github:/nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf/?ref=v0.8";
    niri.url = "github:sodiboo/niri-flake";
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-parts.url = "github:/hercules-ci/flake-parts";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0.tar.gz";
  };
}
