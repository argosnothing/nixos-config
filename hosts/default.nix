# Tie All the hosts together
args: let
  desktop = import ./desktop/default.nix args;
in {
  nixosConfigurations = desktop.nixosConfigurations; # // laptop.nixosConfigurations;
  homeConfigurations = desktop.homeConfigurations; # // laptop.homeConfigurations;
}
