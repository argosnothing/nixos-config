{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./nvf
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./yazi.nix
  ];
}
