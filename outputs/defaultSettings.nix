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
    battery.enable = false;
  };
in
  defaultSettings
