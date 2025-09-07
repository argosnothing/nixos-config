{
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
  mkHome = {
    wm ? "hyprland",
    hostname,
  }: let
    settings =
      defaultSettings
      // {
        inherit hostname wm;
      };
  in {
    "${settings.username}@${settings.hostname}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        (./. + ../hosts + "/${hostname}/home.nix")
      ];
    };
  };
in {
  flake.homeConfigurations =
    mkHome {hostname = "desktop";}
    // mkHome {hostname = "laptop";}
    // mkHome {hostname = "p51";};
}