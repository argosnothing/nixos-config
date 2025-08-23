# Tie All the hosts together
args: let
  desktop = import ./desktop/default.nix args;
  settings = {
    username = "salivala";
    wm = "hyprland";
  };
in {
  nixosConfigurations = desktop.nixosConfigurations; # // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations; # // laptop.homeConfigurations;
}
