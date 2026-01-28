{
  flake.modules.nixos.niri = {
    config,
    lib,
    ...
  }: let
    inherit (config.my) desktop-shells;
    scratchpad-command = ''
      spawn-sh-at-startup "niri-scratchpad daemon"
    '';
    desktop-shell-command = ''
      spawn-at-startup "${desktop-shells.execCommand}"
    '';
    startupCommands = [
      (lib.optionalString (desktop-shells.name != "dank-shell") desktop-shell-command)
      (lib.optionalString config.my.wm.niri.use-scratchpads scratchpad-command)
    ];
  in {
    my.wm.niri.settings = lib.mkAfter startupCommands;
  };
}
