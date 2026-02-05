{
  config,
  inputs,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.niri = {
    pkgs,
    config,
    ...
  }: let
    dots = config.impure-dir;
    niri-settings = builtins.concatStringsSep "\n" config.my.wm.niri.settings;
    nixos-modules = with flake.modules.nixos; [
      wm
      nemo
      icons
      gtk
    ];
  in {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    imports =
      [inputs.niri.nixosModules.niri]
      ++ nixos-modules;
    programs.niri = {
      enable = true;
      package =
        if config.my.wm.niri.use-scratchpads
        then inputs.my-niri.packages.${pkgs.system}.default
        else pkgs.niri-unstable;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    hj.files.".config/niri/config.kdl".source = dots + "/niri/config.kdl";
    my = {
      icons = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine";
      };
      cursor = {
        name = "Simp1e-Dark";
      };
      cursor.enable = true;
      persist.home.directories = [".config/niri"];
    };
  };
}
