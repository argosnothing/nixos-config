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
        (mkImport ./packages)
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
    zed = {
      # url = "github:GoldStrikeArch/zed/feat/add-helix-amp-jump-feature";
      url = "github:zed-industries/zed";
    };
    mnw = {
      url = "github:gerg-l/mnw";
    };
    helix = {
      url = "github:helix-editor/helix";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    matui = {
      url = "github:pkulak/matui";
    };
    ### Window Managers
    niri.url = "github:sodiboo/niri-flake";
    my-niri.url = "github:argosnothing/niri/hidden-workspaces-blur-backdrop-background";
    niri-scratchpad.url = "github:argosnothing/niri-scratchpad/hidden-workspaces";
    scroll = {
      url = "github:AsahiRocks/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ### Desktop Shells
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Display Managers
    ### System Level
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # TODO: periodically check to see if neweest version still has issues with looking glass
    nixpkgs-nvidia = {
      url = "github:NixOS/nixpkgs/46db2e09e1d3f113a13c0d7b81e2f221c63b8ce9";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
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
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    ### Meta
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ### Containerization
    nix-flatpak = {
      url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0.tar.gz";
    };
    ### Other
  };
}
