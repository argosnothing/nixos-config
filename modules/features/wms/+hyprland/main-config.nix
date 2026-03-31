{inputs, ...}: {
  flake.modules.nixos.hyprland = {pkgs, ...}: {
    my.wm.hyprland.configs.main = {
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      route = "main";
    };
  };
}
