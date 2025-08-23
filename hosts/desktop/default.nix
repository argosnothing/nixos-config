# Configure both system and user for this machine
{inputs, pkgs, system, settings, ...}:
{
  nixosConfigurations = {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs settings; };
      modules = [
        ./configuration.nix
      ];
    };
  };

  homeConfigurations = {
    user = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs settings; };
      modules = [
        ./home.nix
      ];
    };
  };
}
