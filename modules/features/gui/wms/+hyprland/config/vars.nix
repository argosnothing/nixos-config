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
        $fileManager = dolphin
        $menu = ${desktop-shells.launcherCommand}
      ''
    ];
  };
}
