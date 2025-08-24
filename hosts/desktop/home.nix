{
  pkgs,
  settings,
  inputs,
  ...
}: {
  imports = [
    ../../nixosModules/user/style/stylix.nix
    ../../nixosModules/user/apps/flatpak/flatpak.nix
    ../../nixosModules/user/apps/firefox.nix
    ../../nixosModules/user/apps/vscode.nix
    ../../nixosModules/user/apps/gtk.nix
    ../../nixosModules/user/wm/hyprland/hyprland.nix
    ../../nixosModules/user/terminal/default.nix
  ];
  home.packages = with pkgs; [
    desktop-file-utils
    spotify
    neofetch
    microsoft-edge
    pulsemixer
    discord
    direnv
    yazi
    libsForQt5.qt5ct
    pkgs.libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    pkgs.noto-fonts-monochrome-emoji
  ];
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme.name = settings.wm;
  };
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [settings.monoFont];
      sansSerif = [settings.sansFont];
      serif = [settings.serifFont];
    };
  };
  programs.bash = {
    enable = true;
  };
  home.sessionVariables = {
    BROWSER = "firefox";
  };
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
