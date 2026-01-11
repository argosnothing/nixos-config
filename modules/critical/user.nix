{config, ...}: let
  inherit (config.flake.settings) username;
in {
  flake.modules.nixos = {
    user = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) types mkOption;
      inherit (types) str;
      actualUsername =
        if config.my.hostname == "nixos"
        then "nixos"
        else username;
    in {
      options.user = {
        name = mkOption {
          type = str;
          default = actualUsername;
        };
      };
      config = {
        programs.fish.enable = true;
        users = {
          users.root.initialPassword = "password";
          users.${actualUsername} = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
            hashedPasswordFile = config.sops.secrets."pc_password".path;
          };
          defaultUserShell = pkgs.bash;
        };
      };
    };
  };
}
