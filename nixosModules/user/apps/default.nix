{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./utilities
    ./flatpak
    ./mpv
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./helix
    ./nvf
    ./git
  ];
}
