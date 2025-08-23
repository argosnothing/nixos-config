# Configure both system and user for this machine
args: let
  system = "x86_64-linux";
  pkgs = args.nixpkgs.legacyPackages.${system};
  settings = {
    username = "salivala";
    wm = "hyprland";
  };
in
{
  nixosConfigurations = {
    desktop = args.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = args;
      modules = [
        ./configuration.nix { inherit args settings;}
      ];
    };
  };

  homeConfigurations = {
    user = args.inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = args;
      modules = [
        ./home.nix { inherit args settings;}
      ];
    };
  };
}