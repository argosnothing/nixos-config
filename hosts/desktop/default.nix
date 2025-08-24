# Configure both system and user for this machine
{inputs, pkgs, pkgsUnstable, system, settings, ...}:
{
    nixosConfigurations = {
      desktop = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs settings pkgsUnstable; };
        modules = [
          ./configuration.nix
        ];
      };
    };  homeConfigurations = {
    "${settings.username}@desktop" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs settings; };
      modules = [
        ./home.nix
      ];
    };
  };
}
