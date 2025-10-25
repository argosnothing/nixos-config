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
    in {
      options.user = {
        name = mkOption {
          type = str;
          default = username;
        };
      };
      config = {
        programs.fish.enable = true;
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
    };
  };
}
