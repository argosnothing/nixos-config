{
  description = "Turtles Strange Nix Configuration";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);
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
      url = "github:zed-industries/zed";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    ### Window Managers
    niri.url = "github:sodiboo/niri-flake";
    my-niri.url = "github:argosnothing/niri/hidden-workspaces-develop";
    niri-scratchpad.url = "github:argosnothing/niri-scratchpad/hidden-workspaces";
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-test.url = "github:vaxerski/hyprland/layouts-rethonked";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    ### Desktop Shells
    dms.url = "github:AvengeMedia/DankMaterialShell";
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      # url = "github:XansiVA/noctalia-shell/main";
      # url = "github:argosnothing/noctalia-shell/testing";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### Display Managers
    silent-sddm = {
      url = "github:/uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ### System Level
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
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
    import-tree = {
      url = "github:vic/import-tree";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    ### Containerization
    nix-flatpak = {
      url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0.tar.gz";
    };
    ### Other
    noogle-search = {
      url = "github:argosnothing/noogle-search";
    };
  };
}
