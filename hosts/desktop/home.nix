{settings, pkgs, ...}: {
  imports = [
    ../../nixosModules/user/apps/firefox.nix
    ../../nixosModules/user/apps/vscode.nix
    ../../nixosModules/user/wm/hyprland/hyprland.nix
    ../../nixosModules/user/terminal/default.nix
  ];
  
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
