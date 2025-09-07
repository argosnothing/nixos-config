# Configure both system and user for this machine
{
  inputs,
  pkgsUnstable,
  ...
}: let
  nixpkgs = import inputs.nixpkgs { 
    system = settings.system;
    config.allowUnfree = true;
  };
  pkgs = nixpkgs;
  settings =
    (import ../defaultSettings.nix { inherit pkgs; })
    // {
      hostname = "desktop";
      wm = "hyprland";
      fonts = {
        sizes = {
          applications = 12;
          terminal = 10;
          desktop = 10;
          popups = 10;
        };
      };
    };
in {
  flake.nixosConfigurations = {
    "${settings.hostname}" = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./configuration.nix
      ];
    };
  };
  flake.homeConfigurations = {
    "${settings.username}@${settings.hostname}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./home.nix
      ];
    };
  };
}
