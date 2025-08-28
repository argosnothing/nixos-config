{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./nvf
    ./firefox.nix
    ./vscode.nix
    ./gtk.nix
    ./nautilus.nix
  ];
}
