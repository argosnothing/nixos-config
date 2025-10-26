{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (lib.lists) optionals;
    inherit (config.my) desktop-shells;
  in {
    hm.programs.niri.settings.spawn-at-startup = optionals (desktop-shells.name != "dank-shell") [
      {argv = ["${desktop-shells.execCommand}"];}
    ];
  };
}
