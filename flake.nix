{
  description = "NixOS with HM (flakes) + Hyprland + hyprland-plugins";

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, dotfiles, hyprland-plugins, nixpkgs-unstable, ... }:
    let
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos"; # hostname
        profile = "work"; # select a profile defined from my profiles directory
        timezone = "America/New_York"; # select timezone
        locale = "en_US.UTF-8"; # select locale
        bootMode = "uefi"; # uefi or bios
        bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
        grubDevice = ""; # device identifier for grub; only used for legacy (bios) boot mode
        gpuType = "amd"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
      };

      # ----- USER SETTINGS ----- #
      userSettings = rec {
        username = "salivala"; # username
        name = "Hayden"; # name/identifier
        email = "argosnothing@gmail.com"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = "ayu-dark"; # selcted theme from my themes directory (./themes/)
        wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11"; # window manager type (hyprland or x11) translator
        browser = "firefox"; # Default browser; must select one from ./user/app/browser/
        spawnBrowser = browser; # Browser spawn command
        defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
        term = "alacritty"; # Default terminal command;
        font = "Fira Code"; # Selected font
        fontPkg = pkgs.fira-code; # Font package
        editor = "neovide"; # Default editor;
        spawnEditor = if (editor == "emacsclient") then
                        "emacsclient -c -a 'emacs'"
                      else
                        (if ((editor == "vim") ||
                             (editor == "nvim") ||
                             (editor == "nano")) then
                               "exec " + term + " -e " + editor
                         else
                         (if (editor == "neovide") then
                           "neovide -- --listen /tmp/nvimsocket" 
                           else
                           editor)); # generates a command that can be used to spawn editor inside a gui
      };

      pkgs-emacs = import inputs.emacs-pin-nixpkgs {
        system = systemSettings.system;
      };
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      system = systemSettings.system;
      pkgsUnstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true;};
      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor =
        forAllSystems (system: import inputs.nixpkgs { inherit system; });

    in {
      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            #./home.nix
	    inputs.nix-doom-emacs-unstraightened.homeModule
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from prof
          ];

          extraSpecialArgs = {
            inherit inputs systemSettings userSettings pkgsUnstable;
          };
        };
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
            ./hardware-configuration.nix
          ];
          specialArgs = {
            inherit inputs systemSettings userSettings lib;
          };
        };
      };

    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    emacs-pin-nixpkgs.url = "nixpkgs/f72123158996b8d4449de481897d855bc47c7bf6";
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "";

    dotfiles.url = "github:argosnothing/dotfiles";
    dotfiles.flake = false;
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
}
