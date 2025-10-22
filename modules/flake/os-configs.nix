{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os)
    linux
    linux-arm
    ;

  flake.nixosConfigurations = {
    mordor = linux "vm";
  };

in
{
  inherit flake;
}

