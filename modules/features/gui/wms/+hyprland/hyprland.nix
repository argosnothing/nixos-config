{
  flake.modules.nixos.hyprland = {pkgs, ...}: {
    my.persist.home = {
      directories = [
        ".config/hypr"
      ];
    };
    programs.hyprland = {
      enable = true;
    };
  };
}
