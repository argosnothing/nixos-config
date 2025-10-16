{pkgs, ...}: let
  defaultSettings = rec {
    isvm = false;
    zfs = {
      hostId = "AB12CD34";
      devNodes =
        "/dev/disk/"
        + (
          if isvm
          then "by-partuuid"
          else "by-id"
        );
    };
    system = "x86_64-linux";
    username = "salivala";
    gitEmail = "argosnothing@gmail.com";
    # firmware needs to be declared in the host explicitly.
    homedir = "nixos-config";
    flakedir = "~/${defaultSettings.homedir}";
    absoluteflakedir = "/home/${defaultSettings.username}/${defaultSettings.homedir}/";
    battery.enable = false;
  };
in
  defaultSettings
