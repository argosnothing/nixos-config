{
  inputs,
  pkgs,
  pkgsUnstable,
  ...
}: let
  defaultSettings = import ./defaultSettings.nix {inherit pkgs;};
  inherit (inputs) nixpkgs self;
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
    ${hostname} = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs settings pkgsUnstable self;};
      modules = [
        (../hosts + "/${hostname}/configuration.nix")
      ];
    };
  };
in {
  flake.nixosConfigurations =
    mkSystem {hostname = "desktop"; wm = "niri";}
    // mkSystem {hostname = "laptop";}
    // mkSystem {hostname = "p51";};
}
