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
      extraSpecialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        ./home.nix
      ];
    };
  };
}
