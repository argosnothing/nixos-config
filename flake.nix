{
  description = "Turtles Strange Nix Configuration";

  #  https://github.com/Michael-C-Buckley/nixos/blob/156070cec0f70b1d448b9e36b7f5259248e107f2/flake.nix#L36
  outputs = {
    nixpkgs,
    flake-parts,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) hasPrefix lists;
    inherit (nixpkgs.lib.fileset) toList fileFilter;
    mkImport = path: toList (fileFilter (f: f.hasExt "nix" && !(hasPrefix "_" f.name)) path);
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];
      imports = lists.flatten [
        (mkImport ./modules)
      ];
      perSystem = {system, ...}: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };
    };
  inputs = {
    ### Userland
    hjem = {
      url = "github:/feel-co/hjem";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };
    ### Applications
    helix = {
      url = "github:helix-editor/helix";
    };
    ### System Level
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/release-25.05";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Meta
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ### Other
  };
}
