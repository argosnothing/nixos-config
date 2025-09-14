{lib,...}: {
  imports = [
    ./noctalia-shell.nix
    ./caelestia-shell.nix
  ];
  options.custom.ricing.shells.shell = lib.mkOption {
    default = null;
    type = with lib.types; nullOr (enum ["noctalia-shell" "caelestia-shell"]);
    description = "Add a shell to spice up compositor";
  };
}
