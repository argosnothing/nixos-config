{
  flake.modules.nixos.plex = {
    services = {
      plex = {
        enable = true;
      };
    };
  };
}
