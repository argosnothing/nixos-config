{
  pkgs,
  settings,
  inputs,
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
    nix-direnv
    nix-direnv-flakes
    direnv
    spotify
    bolt-launcher
    inputs.self.packages.${pkgs.system}.ns
    inputs.self.packages.${pkgs.system}.nvf
  ];

  mpv.enable = true;
  programs.bash = {
    enable = true;
  };
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.05";

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [settings.monoFont];
      sansSerif = [settings.sansFont];
      serif = [settings.serifFont];
    };
  };
}
