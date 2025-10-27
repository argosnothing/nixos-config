{
  flake.modules.nixos.misc-scripts = {pkgs, ...}: {
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
    ];
  };
}
