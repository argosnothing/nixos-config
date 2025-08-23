{inputs, pkgs, ...}: let
  pkgs-hyprland = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ../services/dbus.nix
    ../services/gnome-keyring.nix
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gtk3
    gtk4
    glib
    gsettings-desktop-schemas
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    portalPackage = pkgs-hyprland.xdg-desktop-portal-hyprland;
  };

  services.xserver.excludePackages = [ pkgs.xterm ];
  programs.dconf.enable = true;
  services.dbus.enable = true;
}