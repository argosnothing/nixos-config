{
  flake.modules.nixos.desktop = {
    config,
    lib,
    modulesPath,
    pkgs,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      initrd.kernelModules = [];
      kernelModules = ["kvm-amd"];
      kernelParams = [
        "nvidida-drm.fbdev=1"
        "NVreg_EnableGpuFirmware=0"
        "usbcore.autosuspend=-1"
      ];
      extraModulePackages = [];
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.enableRedistributableFirmware = true;
    hardware.firmware = [pkgs.broadcom-bt-firmware];
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Moving this audio stuff here because its an eyesore and i don't like looking at it. also it's technically a hardware configuration
    # bite me.
    services.pipewire.wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/50-default-sink.conf" ''
        wireplumber.settings = {
          default.configured-audio-sink = "alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K7-00.analog-stereo"
        }
      '')
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-fiio-k7-profile.conf" ''
        monitor.alsa.rules = [
          {
            matches = [
              { device.name = "alsa_card.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K7-00" }
            ]
            actions = {
              update-props = {
                device.profile = "output:analog-stereo"
              }
            }
          }
        ]
      '')
    ];
  };
}
