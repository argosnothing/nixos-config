{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./nvf
    ./mpv
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./yazi.nix
  ];
}
