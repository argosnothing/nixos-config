{
  config,
  lib,
  pkgs,
  ...
}: let
  gget = pkgs.writeShellScriptBin "gget" (builtins.readFile ./gget.sh);
  ggrab = pkgs.writeShellScriptBin "ggrab" (builtins.readFile ./ggrab.sh);
in {
  imports = [./nh.nix];
  options.my.modules.shell.scripts.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable custom shell scripts.";
  };

  config = lib.mkIf config.my.modules.shell.scripts.enable {
    environment.systemPackages = [
      (import ./show-tmpfs.nix {inherit pkgs;})
      gget
      ggrab
    ];
  };
}
