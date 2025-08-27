{
  pkgs,
  settings,
  ...
}: {
  # Shared home-manager configuration for all hosts
  imports = [
    ../nixosModules/user
  ];

  # Core packages shared across all hosts
  home.packages = with pkgs; [
    desktop-file-utils
    discord
    pulsemixer
    tdrop
    spotify
  ];

  # Basic program configuration
  programs.bash = {
    enable = true;
  };
  programs.home-manager.enable = true;

  # User directory configuration
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # State version
  home.stateVersion = "25.05";

  # Session variables
  home.sessionVariables = {
    BROWSER = "firefox";
  };

  # Font configuration
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [settings.monoFont];
      sansSerif = [settings.sansFont];
      serif = [settings.serifFont];
    };
  };

  # Qt configuration
  qt = {
    enable = true;
    style.package = pkgs.libsForQt5.breeze-qt5;
    style.name = "breeze-dark";
    platformTheme.name = settings.wm;
  };
}
