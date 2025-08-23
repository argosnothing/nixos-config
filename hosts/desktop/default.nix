# Configure both system and user for this machine
{inputs, ...}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  settings = {
    username = "salivala";
    wm = "hyprland";
  };
in
{
  nixosConfigurations = {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs;
      modules = [
        ./configuration.nix { inherit settings;}
      ];
    };
  };

  homeConfigurations = {
    user = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = inputs;
      modules = [
        ./home.nix { inherit settings;}
      ];
    };
  };
}