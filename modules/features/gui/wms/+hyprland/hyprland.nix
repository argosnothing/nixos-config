{
  config,
  inputs,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.hyprland = {
    pkgs,
    config,
    lib,
    ...
  }:
    with lib; let
      plugin-pkgs = inputs.hyprland-plugins.packages.${pkgs.system};
      plugin-dir = pkgs.symlinkJoin {
        name = "hyprland-plugins";
        paths = [
          inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
        ];
      };
      hyprland-settings = builtins.concatStringsSep "\n" config.my.wm.hyprland.settings;
      nixos-modules = with flake.modules.nixos; [
        wm
        nemo
        icons
        gtk
      ];
    in {
      imports = nixos-modules;
      environment.sessionVariables = {HYPR_PLUGIN_DIR = plugin-dir;};
      my = {
        icons = {
          package = pkgs.rose-pine-icon-theme;
          name = "rose-pine";
        };
        cursor = {
          enable = true;
          name = "Simp1e-Dark";
        };
      };
      my.persist.home = {
        directories = [
          ".config/hypr"
        ];
      };
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
      hj.files.".config/hypr/hyprland.conf".text = hyprland-settings;
    };
}
