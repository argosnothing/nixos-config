{ pkgs, config, lib, ... }: {
  imports = [
    ./flatpak.nix
    ./via.nix
    ./steam.nix
  ];
  programs.firefox.enable = true;
}
