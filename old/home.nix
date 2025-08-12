{pkgs, ... }:
let
	aliases = {
	    updatehome = "home-manager switch --flake ~/.dotfiles/#salivala";
	    updatesystem = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
	};
in {
  imports = [./modules/hyprland.nix];
  home.username = "salivala";
  home.homeDirectory = "/home/salivala";
  programs.home-manager.enable = true;
  #services.flatpak.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };

# Cursor theme (fixes the “awful” default)
home.pointerCursor = {
  gtk.enable = true;
  name = "Bibata-Modern-Ice";
  package = pkgs.bibata-cursors;
  size = 24;
};

# Make sure non‑GTK apps + Hyprland see it
home.sessionVariables = {
  XCURSOR_THEME = "Bibata-Modern-Ice";
  XCURSOR_SIZE = "24";
};

# Hyprland: export at compositor start
wayland.windowManager.hyprland.settings.env = [
  "XCURSOR_THEME,Bibata-Modern-Ice"
  "XCURSOR_SIZE,24"
];

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;

    # HM will install these for your user; no need to add to home.packages
    extraPortals = with pkgs; [
     #xdg-desktop-portal-hyprland
    ];

    # Prefer Hyprland; GTK as fallback
    config.common.default = [ "hyprland" ];
  };

  home.packages = with pkgs; [
    source-code-pro
    kitty
    wofi
    rofi
    gitkraken
    wl-clipboard
    hyprshot
    spotify
    pulsemixer
  ];


  home.stateVersion = "25.05";  # match your system; ok to keep as-is
}
