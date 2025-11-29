{
  description = "Turtles Strange Nix Configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);
  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:/feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    nvf = {
      url = "github:michael-c-buckley/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    oxwm = {
      url = "github:argosnothing/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    occult-theme.url = "github:/argosnothing/occult-theme";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs = {
        dgop.follows = "dgop";
        nixpkgs.follows = "nixpkgs";
      };
    };
    silent-sddm = {
      url = "github:/uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-grub-themes = {
      url = "github:jeslie0/nixos-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0.tar.gz";
    };
    zwift.url = "github:netbrain/zwift";
  };
}
