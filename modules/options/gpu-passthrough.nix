{lib, ...}: {
  flake.modules.nixos.options = {
    options.my.gpu-passthrough = {
      ids = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "PCI vendor:device IDs to bind to vfio-pci at boot (e.g. [\"10de:2204\" \"10de:1aef\"])";
        example = ["10de:2204" "10de:1aef"];
      };
      kvmfr-size = lib.mkOption {
        type = lib.types.int;
        default = 32;
        description = "Size in MB for the kvmfr shared memory buffer. 32MB covers up to 1440p SDR.";
      };
    };
  };
}
