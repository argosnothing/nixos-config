{ config, settings, lib, pkgs, ... }:

let
  gget = pkgs.writeShellScriptBin "gget" (builtins.readFile ./gget.sh);
  ggrab = pkgs.writeShellScriptBin "ggrab" (builtins.readFile ./ggrab.sh);
  rebuilds = pkgs.writeShellScriptBin "rebuilds" (import ./rebuilds.sh {inherit settings;});
  rebuildb = pkgs.writeShellScriptBin "rebuildb" (import ./rebuildb.sh {inherit settings;});
in
{
  imports = [./nh.nix];
  options.scripts.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable custom shell scripts.";
  };

  config = lib.mkIf config.scripts.enable {
    environment.systemPackages = [
      gget
      ggrab
      rebuilds
      rebuildb
    ];
  };
}
