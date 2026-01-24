{inputs, ...}: {
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    ...
  }: {
    my.wm.niri.settings = lib.mkAfter [
      ''
        workspace "stash" {
            open-on-output "DP-1"
            hidden true
        }
        workspace "work" {
            open-on-output "DP-1"
            hidden true
        }
        workspace "test" {
            open-on-output "DP-1"
        }
      ''
    ];
    environment.systemPackages = [
      inputs.niri-scratchpad.packages.${pkgs.system}.default
    ];
  };
}
