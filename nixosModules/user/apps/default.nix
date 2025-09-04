{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./nvf
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./gtk.nix
    ./yazi.nix
  ];
}
