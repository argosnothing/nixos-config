{
  flake.modules.nixos.spotify-player = {
    my.persist = {
      home = {
        directories = [
          ".config/spotify-player"
        ];
        cache.directories = [
          ".cache/spotify-player"
        ];
      };
    };
  };
}
