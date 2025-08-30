# Configure both system and user for this machine
{
  inputs,
  pkgs,
  pkgsUnstable,
  system,
  defaultSettings,
  ...
}: let
  settings =
    defaultSettings
    // {
      hostname = "desktop";
      wm = "plasma";
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
  nixosConfigurations = {
    "${settings.hostname}" = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./configuration.nix
      ];
    };
  };
  homeConfigurations = {
    "${settings.username}@${settings.hostname}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./home.nix
      ];
    };
  };
}
