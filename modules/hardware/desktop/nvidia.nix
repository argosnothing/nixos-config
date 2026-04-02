{inputs, ...}: let
  pkgs-nvidia = import inputs.nixpkgs-nvidia {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  flake.modules.nixos.desktop = {config, ...}: {
    my.persist.home.cache.directories = [".cache/nvidia"];
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = (pkgs-nvidia.linuxKernel.packagesFor config.boot.kernelPackages.kernel).nvidiaPackages.stable;
    };
  };
}
