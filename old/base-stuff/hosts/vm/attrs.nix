rec {
  isvm = true;
  boot = {
    firmware = "uefi";
  };
  zfs = {
    hostId = "deadbeef";
    devNodes =
      "/dev/disk/"
      + (
        if isvm
        then "by-partuuid"
        else "by-id"
      );
  };
}
