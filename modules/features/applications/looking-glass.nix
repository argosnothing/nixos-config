{config, ...}: let
  virtualizationModule = config.flake.modules.nixos.virtualization;
in {
  flake.modules.nixos.looking-glass = {
    config,
    pkgs,
    lib,
    ...
  }: let
    cfg = config.my.gpu-passthrough;
  in {
    imports = [virtualizationModule];

    boot = {
      kernelParams =
        [
          "amd_iommu=on"
          "iommu=pt"
        ]
        ++ lib.optional (cfg.ids != [])
        "vfio-pci.ids=${lib.concatStringsSep "," cfg.ids}";

      initrd.kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1"];

      extraModulePackages = [config.boot.kernelPackages.kvmfr];
      kernelModules = ["kvmfr"];
      extraModprobeConfig = "options kvmfr static_size_mb=${toString cfg.kvmfr-size}";
    };

    virtualisation.libvirtd.qemu.swtpm.enable = true;

    virtualisation.libvirtd.qemu.verbatimConfig = ''
      namespaces = []
      cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
        "/dev/rtc", "/dev/hpet", "/dev/vfio/vfio",
        "/dev/kvmfr0"
      ]
    '';

    services.udev.packages = lib.singleton (
      pkgs.writeTextFile
      {
        name = "kvmfr";
        text = ''
          SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
        '';
        destination = "/etc/udev/rules.d/70-kvmfr.rules";
      }
    );

    my.persist.root.directories = ["/var/lib/libvirt"];

    environment.systemPackages = [
      (pkgs.looking-glass-client.overrideAttrs (old: {
        postFixup =
          (old.postFixup or "")
          + ''
            substituteInPlace $out/share/applications/looking-glass-client.desktop \
              --replace-fail "Exec=" "Exec=env __NV_DISABLE_EXPLICIT_SYNC=1 "
          '';
      }))
    ];
  };
}
