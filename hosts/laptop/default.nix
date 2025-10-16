# Configure both system and user for this machine
{
  inputs,
  pkgs,
  username,
  hostname,
  ...
}: let
  settings =
    (import ../defaultSettings.nix {inherit pkgs;})
    // {
      hostname = "laptop";
      wm = "hyprland";
      battery.enable = true;
      fonts = {
        sizes = {
          applications = 10;
          terminal = 10;
          desktop = 10;
          popups = 10;
        };
      };
    };
in {
  flake.nixosConfigurations = {
    "${hostname}" = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings;};
      modules = [
        ./configuration.nix
      ];
    };
  };
  flake.homeConfigurations = {
    "${username}@${hostname}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs settings;};
      modules = [
        ./home.nix
      ];
    };
  };
}
