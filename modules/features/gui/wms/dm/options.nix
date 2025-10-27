# Idk maybe ill need this?
{
  flake.modules.nixos.display-manager = {lib, ...}: let
    inherit (lib) types;
  in {
    options = {

    };
  };
}
