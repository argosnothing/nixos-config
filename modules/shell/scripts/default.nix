{
  config,
  lib,
  pkgs,
  ...
}: let
  gget = pkgs.writeShellScriptBin "gget" (builtins.readFile ./gget.sh);
  ggrab = pkgs.writeShellScriptBin "ggrab" (builtins.readFile ./ggrab.sh);
in {
  imports = [
    ./scripts.nix
    ./nh.nix
  ];
  options.my.modules.shell.scripts.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable custom shell scripts.";
  };

  config = lib.mkIf config.my.modules.shell.scripts.enable {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "systest" ''
        set -euo pipefail
        if [ $# -lt 1 ]; then
          echo "usage: systest <hostname> [build args...]" >&2
          exit 1
        fi
        host="$1"; shift
        nix build ".#nixosConfigurations.''${host}.config.system.build.toplevel" "$@"
      '')
      (import ./show-tmpfs.nix {inherit pkgs;})
      gget
      ggrab
    ];
  };
}
