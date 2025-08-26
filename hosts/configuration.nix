{
  inputs,
  pkgs,
  config,
  pkgsUnstable,
  settings,
  lib,
  ...
}: {
  options = {
    kernels.xandmod.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Xanmod kernel.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.kernels.xandmod.enable {
      boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
    })
    {
      networking.hostName = settings.hostname;
    }
  ];
}
