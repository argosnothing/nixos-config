# Configure both system and user for this machine
{
  inputs,
  pkgs,
  pkgsUnstable,
  system,
  defaultSettings,
  ...
}: let
  settings = defaultSettings // {
    hostname = "laptop";
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
      extraSpecialArgs = {inherit inputs settings;};
      modules = [
        ./home.nix
      ];
    };
  };
}
