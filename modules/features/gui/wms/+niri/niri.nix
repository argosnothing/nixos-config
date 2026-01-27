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
      #package = pkgs.niri-unstable;
      package = inputs.my-niri.packages.${pkgs.system}.default;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    hj.files.".config/niri/config.kdl".text = niri-settings;
    quantum.entangle-folders = {
      "niri/.config/gtk-3.0" = ".config/gtk-3.0";
      "niri/.config/gtk-4.0" = ".config/gtk-4.0";
    };
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
