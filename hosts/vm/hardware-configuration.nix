{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Dummy root so evaluation passes (will be replaced later)
  fileSystems."/" = {
    device = "dummy";
    fsType = "tmpfs";
  };

  # Required attr, even if nonsense
  swapDevices = [ ];

  # Just to avoid surprises
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
}
