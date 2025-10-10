{...}: {
  imports = [
    ../shared/configuration.nix
    ./hardware-configuration.nix
  ];
  my = {
    persist.enable = true;
    modules = {
      critical.zfs.enable = true;
      monitors = [
        {
          name = "Virtual-1";
          is-primary = true;
          dimensions = {
            width = 1920;
            height = 1080;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
