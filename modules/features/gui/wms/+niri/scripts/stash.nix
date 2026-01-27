{inputs, ...}: {
  flake.modules.nixos.niri = {
    pkgs,
    lib,
    config,
    ...
  }: {
    my.wm.niri.settings =
      if config.my.wm.niri.use-scratchpads
      then
        lib.mkAfter [
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
        ]
      else lib.mkAfter [];
    environment.systemPackages = [
      inputs.niri-scratchpad.packages.${pkgs.system}.default
    ];
  };
}
