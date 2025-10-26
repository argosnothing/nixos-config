{
  flake.modules.nixos.grub = {
    pkgs,
    inputs,
    ...
  }: {
    boot = {
      plymouth.enable = true;
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          devices = ["nodev"];
        };
        grub.theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
        efi.canTouchEfiVariables = true;
      };
      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "loglevel=3"
        "systemd.show_status=false"
        "rd.udev.log_priority=3"
        "vt.global_cursor_default=0" # optional, hides blinking cursor
      ];
      kernel.sysctl."kernel.printk" = "3 3 3 3";
    };
  };
}
