{
  pkgs,
  settings,
  ...
}: {
  imports = [
    ../../nixosModules/user
  ];
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    desktop-file-utils
    discord
    nautilus
    pulsemixer
    loupe
    spotify
  ];
  programs.bash = {
    enable = true;
  };
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
