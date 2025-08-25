{
  pkgs,
  settings,
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
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    desktop-file-utils
    discord
    nautilus
    loupe
  ];
  programs.bash = {
    enable = true;
  };
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05";
}
