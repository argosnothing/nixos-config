{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./nvf
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./schizofox
    ./gtk.nix
    ./yazi.nix
  ];
}
