{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (lib.lists) optionals;
    inherit (config.my) desktop-shells;
    startupCommands = optionals (desktop-shells.name != "dank-shell") [
      ''
        spawn-at-startup "${desktop-shells.execCommand}"
        spawn-sh-at-startup "niri-scratchpad daemon"
      ''
    ];
  in {
    my.wm.niri.settings = lib.mkAfter startupCommands;
  };
}
