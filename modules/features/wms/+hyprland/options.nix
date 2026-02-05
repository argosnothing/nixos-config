### Hyprland options
## Justification!
## I love unnecessary abstractions!
## Couple a config with a particular version of hyprland, because vaxry
# I have 1 hyprland config right now, it's testing. If I were smart i'd have saved my old one. oops!
# Idea: consumers provide a route and a package
# package: the package to use
# route: identifier used to index config relative to flakedir/.impure/hyprland
# Meant to also hook into hjem-impure for when I need to run quick and tweaking without rebuild
{
  flake.modules.nixos.hyprland = {lib, ...}: let
    inherit (lib) mkOption;
    inherit (lib.types) submodule package str attrsOf;
    hyprland-config = submodule {
      options = {
        package = mkOption {type = package;};
        route = mkOption {type = str;};
      };
    };
  in {
    options.my.wm.hyprland = {
      active-config = mkOption {type = str;};
      configs = mkOption {
        type = attrsOf hyprland-config;
        default = {};
      };
    };
  };
}
