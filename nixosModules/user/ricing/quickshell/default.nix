{pkgs, lib, settings, ...}: {
  home.packages = with pkgs; [
    quickshell
  ];
}