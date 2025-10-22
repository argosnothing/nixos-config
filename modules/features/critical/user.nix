{lib, config, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) str;
in {
  options.user = {
    username = mkOption {
      description = "Its me!";
      type = str;
      default = "salivala";
    };
  };

  flake.modules.critical = {pkgs, ...}: let
    inherit (config.flake.user) username;
  in {
    users = {
      users.root.initialPassword = "password";
      users.${username} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
        hashedPasswordFile = config.sops.secrets."pc_password".path;
      };
      defaultUserShell = pkgs.fish;
    };
  };
}
