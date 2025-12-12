{
  flake.modules.nixos.hyprland = {
    lib,
    config,
    ...
  }: let
    inherit (config.my) desktop-shells;
  in {
    my.wm.hyprland.settings = lib.mkAfter [
      ''
        exec-once = ${desktop-shells.execCommand}
      ''
    ];
  };
}
