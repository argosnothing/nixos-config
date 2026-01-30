{lib, ...}: {
  options.my = {
    startup-services = lib.mkOption {
      description = "Services to start after the WM is initialized";
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
