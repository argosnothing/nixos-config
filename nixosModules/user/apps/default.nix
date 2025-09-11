{pkgs, ...}: {
  home.packages = with pkgs; [ gh ];
  imports = [
    ./terminal
    ./flatpak
    ./mpv
    ./firefox.nix
    ./vscode.nix
    ./zed
    ./helix
    ./nvf
  ];
}
