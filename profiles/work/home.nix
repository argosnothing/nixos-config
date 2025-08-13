{pkgs, userSettings, inputs, config, ... }:
let
  aliases = {
    updatehome = "home-manager switch --flake ~/.dotfiles/#user";
    updatesystem = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
  };
in {
  imports = [
    ../../user/app/browser/firefox.nix
    (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
    ../../user/style/stylix.nix # Styling and themes for my apps
    ../../user/app/flatpak/flatpak.nix
  ];
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  programs.home-manager.enable = true;

  programs.doom-emacs = {
   enable = true;
   doomDir = ./doom.d/doomdir;
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

  xdg.enable = true;
  # Make sure non‑GTK apps + Hyprland see it
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  # Hyprland: export at compositor start
  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_THEME,Bibata-Modern-Ice"
    "XCURSOR_SIZE,24"
  ];

  nixpkgs.config.allowUnfree = true;
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = if (config.stylix.polarity == "dark") then "Papirus-Dark" else "Papirus-Light";
  };

  home.packages = with pkgs; [
    kitty
    wofi
    rofi
    gitkraken
    wl-clipboard
    hyprshot
    spotify
    pulsemixer
    nmap
    fd
    traceroute
    (pkgs.writeShellScriptBin "gget" ''
    set -euo pipefail
    u="$1"
    if [[ "$u" == https://github.com/*/blob/* ]]; then
      raw="$(printf %s "$u" | sed -E 's#https://github.com/#https://raw.githubusercontent.com/#; s#/blob/#/#')"
    else
      raw="$u"
    fi
    if [ $# -ge 2 ]; then out="$2"; else out="$(basename "$u")"; fi
    curl -L "$raw" -o "$out"
  '')
  ];


  home.stateVersion = "25.05";  # match your system; ok to keep as-is
}
