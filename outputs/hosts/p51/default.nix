# Configure both system and user for this machine
{
  inputs,
  pkgs,
  pkgsUnstable,
  system,
  ...
}: let
  settings = import ../defaultSettings.nix // {
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
      inherit system;
      specialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./configuration.nix
      ];
    };
  };
  flake.homeConfigurations = {
    "${settings.username}@${settings.hostname}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs settings;};
      modules = [
        ./home.nix
      ];
    };
  };
}
