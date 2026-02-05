{inputs, ...}: {
  flake.modules.nixos.hyprland = {pkgs, ...}: {
    my.wm.hyprland.configs.testing = {
      package = inputs.hyprland-test.packages.${pkgs.system}.hyprland;
      route = "testing";
    };
  };
}
