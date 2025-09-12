{
  pkgs,
  lib,
  config,
  settings,
  ...
}: {
  options = {
    grub.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "For now lets assume it's the default";
    };
  };
  config = lib.mkIf config.grub.enable {
    boot.plymouth.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.consoleLogLevel = 3;
    boot.kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "rd.udev.log_priority=3"
      "vt.global_cursor_default=0" # optional, hides blinking cursor
    ];
    boot.kernel.sysctl."kernel.printk" = "3 3 3 3";
  };
}
