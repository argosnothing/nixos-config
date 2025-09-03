{ config, lib, pkgs, ... }:

let
  gget = pkgs.writeShellScriptBin "gget" (builtins.readFile ./gget.sh);
  ggrab = pkgs.writeShellScriptBin "ggrab" (builtins.readFile ./ggrab.sh);
in
{
  options.scripts.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable custom shell scripts.";
  };

  config = lib.mkIf config.scripts.enable {
    home.packages = [
      gget
      ggrab
    ];
  };
}
