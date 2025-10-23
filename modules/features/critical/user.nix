{
  lib,
  config,
  ...
}: {
  flake.modules.nixos.critical = {pkgs, ...}: let
    #   inherit (config.flake.settings) username;
  in {
    #   users = {
    #     users.root.initialPassword = "password";
    #     users.${username} = {
    #       isNormalUser = true;
    #       extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
    #       hashedPasswordFile = config.sops.secrets."pc_password".path;
    #     };
    #     defaultUserShell = pkgs.fish;
    # };
  };
}
