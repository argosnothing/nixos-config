{
  pkgs,
  lib,
  config,
  inputs,
  settings,
  ...
}: {
  options = {
    grub.enable = lib.mkEnableOption "grub firmware";
  };
  config = lib.mkIf config.grub.enable {
    boot.plymouth.enable = true;
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
    };
    boot.loader.grub.theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
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
