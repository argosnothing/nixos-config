# Configure both system and user for this machine
{
  inputs,
  pkgs,
  pkgsUnstable,
  ...
}: let
  settings =
    (import ../defaultSettings.nix {inherit pkgs;})
    // {
      hostname = "p51";
      wm = "hyprland";
      battery.enable = true;
      fonts = {
        sizes = {
          applications = 8;
          terminal = 8;
          desktop = 8;
          popups = 8;
        };
      };
    };
in {
  flake.nixosConfigurations = {
    "${settings.hostname}" = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs settings pkgsUnstable;};
      inherit pkgs;
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
