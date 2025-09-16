{
  pkgs,
  settings,
  lib,
  config,
  ...
}: {
  options = {
    uefi.enable = lib.mkEnableOption "Enable UEFI firmware";
  };

  config = lib.mkIf config.uefi.enable {
    boot.loader.grub.enable = false;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
