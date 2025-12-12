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
    ...
  }: let
    hyprland-settings = builtins.concatStringsSep "\n" config.my.wm.hyprland.settings;
    nixos-modules = with flake.modules.nixos; [
      wm
      nemo
      icons
      gtk
    ];
  in {
    imports = nixos-modules;
    my.cursor.enable = true;
    my.persist.home = {
      directories = [
        ".config/hypr"
      ];
    };
    programs.hyprland = {
      enable = true;
    };

    hj.files.".config/hypr/hyprland.conf".text = hyprland-settings;
  };
}
