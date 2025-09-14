# Tie All the hosts together
{ inputs, ... }: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [
    ./desktop
    ./laptop
    ./p51
    ./vm
  ];

  _module.args = {
    inherit pkgs;
  };
}
