{ pkgs, config, lib, ... }: {
  imports = [
    ./flatpak.nix
    ./via.nix
  ];
}
