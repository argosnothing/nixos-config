{
  flake.modules.nixos.ly = {config, ...}: {
    services = {
      displayManager = {
        defaultSession = config.my.session.name;
        ly = {
          enable = true;
          settings = {
            bigclock = "en";
          };
        };
      };
    };
  };
}
