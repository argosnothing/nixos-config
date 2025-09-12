rec {
  isvm = false;
  boot = {
    firmware = "uefi";
  };
  zfs = {
    hostId = "AB12CD34";
    devNodes = "/dev/disk/" + (if isvm then "by-partuuid" else "by-id");
  };
}
