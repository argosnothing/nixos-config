{settings, ...}: {
  imports = [
    ../../nixosModules/user/apps/firefox.nix
    ../../nixosModules/user/apps/vscode.nix
  ];
  
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  home.stateVersion = "25.05";
}