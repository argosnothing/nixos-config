{
  lib,
  config,
  ...
}: {
  options.my.modules.critical.uefi = {
    enable = lib.mkEnableOption "Enable UEFI firmware";
  };

  config = lib.mkIf config.my.modules.critical.uefi.enable {
    boot = {
      loader = {
        grub.enable = false;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
