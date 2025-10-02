{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) nullOr enum str listOf;
in {
  imports = [
    ./noctalia-shell.nix
    ./caelestia-shell.nix
    ./dank-shell.nix
  ];
  options.my.modules.gui.desktop-shells = {
    name = mkOption {
      default = null;
      type = nullOr (enum [
        "noctalia-shell"
        "caelestia-shell"
        "dank-shell" #https://github.com/AvengeMedia/DankMaterialShell/issues/186#issuecomment-3275793282
      ]);
      description = "Add a shell to spice up compositor";
    };
    execCommand = mkOption {
      type = str;
      description = "Command that starts the Desktop Shell";
    };
    launcherCommand = mkOption {
      type = str;
      description = "Command that starts the App Launcher";
    };
    bind = mkOption {
      type = listOf str;
      description = "Maps to bind in hyprland ( and hopefully we can use this in niri later)";
    };
    bindl = mkOption {
      type = listOf str;
      description = "Maps onto whatever bindl means in hyprland";
    };
  };
}
