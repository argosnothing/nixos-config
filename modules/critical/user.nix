{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
  inherit (config.my.modules.critical.user) name;
in {
  options = {
    my.modules.critical.user.name = mkOption {
      description = "The singular user for this system";
      type = str;
    };
  };

  config = {

  users = {
    users.root.initialPassword = "password";
      users.${name} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
        hashedPasswordFile = config.sops.secrets."pc_password".path;
      };
      defaultUserShell = pkgs.fish;
    };
  };
}
