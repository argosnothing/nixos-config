{pkgs, pkgsUnstable, userSettings, inputs, config, ... }:
let
  aliases = {
    updatehome = "home-manager switch --flake ~/.dotfiles/#user";
    updatesystem = "sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos";
    updateemacs = "nix run ~/.dotfiles/profiles/work/doom.d/#doom-emacs";
  };
in {
  imports = [
    ../../user/app/browser/firefox.nix
    (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
    ../../user/style/stylix.nix
    ../../user/app/flatpak/flatpak.nix
    ../../user/app/doom-emacs/doom.nix
  ];
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = aliases;
  };

  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "1a3196da1c70423faaab8f7c4d46d184";
    };
  };
  #stylix.targets.spotify-player.enable = true;

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

  stylix.targets.nixcord.enable = true;

  nixpkgs.config.allowUnfree = true;
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = if (config.stylix.polarity == "dark") then "Papirus-Dark" else "Papirus-Light";
  };

  programs.vesktop.enable = true;
  programs.firefox = {
    enable = true;
  };
  stylix.targets.firefox = {
    enable = true;
    profileNames = ["default"];
  };
  stylix.targets.vesktop.enable = true;

  home.packages =
    (with pkgs;[
        kitty
        wofi
        rofi
        gitkraken
        wl-clipboard
        hyprshot
        pulsemixer
        nmap
        fd
        traceroute
        neofetch
        discord
        vesktop
        spotify-player
        spotify
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
  ]) ++ (with pkgsUnstable; [uhk-agent]);
  home.stateVersion = "25.05";  # match your system; ok to keep as-is
}
