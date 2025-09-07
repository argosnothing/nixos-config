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
  mkSystem = {
    wm ? "hyprland",
    hostname,
  }: let
    settings =
      defaultSettings
      // {
        inherit hostname wm;
      };
  in {
    ${hostname} = pkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings pkgsUnstable;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
      ];
    };
  };
in {
  flake.nixosConfigurations =
    mkSystem {hostname = "desktop";}
    // mkSystem {hostname = "laptop";}
    // mkSystem {hostname = "p51";};
}
