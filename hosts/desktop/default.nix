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
      specialArgs = inputs // { inherit settings; };
      modules = [
        ./configuration.nix
      ];
    };
  };

  homeConfigurations = {
    user = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = inputs // { inherit settings; };
      modules = [
        ./home.nix
      ];
    };
  };
}
