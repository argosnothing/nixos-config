{lib, ...}:let 
  inherit (lib) mkOption;
  inherit (lib.types) nullOr enum string bool;
  in {
  imports = [
    ./noctalia-shell.nix
    ./caelestia-shell.nix
  ];
  options.custom.desktop-shell = {
    name = mkOption {
      default = null;
      type = nullOr (enum ["noctalia-shell" "caelestia-shell"]);
      description = "Add a shell to spice up compositor";
    };
    execCommand = mkOption {
      type = string;
      description = "Command that starts the Desktop Shell";
    };
    launcherCommand = mkOption {
      type = string;
      description = "Command that starts the App Launcher";
    };
  };
}
