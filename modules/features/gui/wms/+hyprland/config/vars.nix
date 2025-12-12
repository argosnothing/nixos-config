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
        $terminal = kitty
        $fileManager = nemo
        $menu = ${desktop-shells.launcherCommand}
      ''
    ];
  };
}
