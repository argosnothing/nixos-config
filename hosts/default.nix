# Tie All the hosts together
{inputs, ...}: let
  desktop = import ./desktop/default.nix {inherit inputs;};
  settings = {
    username = "salivala";
    wm = "hyprland";
  };
in {
  nixosConfigurations = desktop.nixosConfigurations; # // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations; # // laptop.homeConfigurations;
}
