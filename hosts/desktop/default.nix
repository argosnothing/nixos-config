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
    hostname = "desktop";
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
