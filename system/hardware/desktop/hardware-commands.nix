{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "updatesystem" ''
      #!/bin/sh
      set -eu
      flake="$HOME/.dotfiles#desktop"
      exec /run/wrappers/bin/sudo nixos-rebuild switch --flake "$flake" "$@"
    '')
  ];
}
