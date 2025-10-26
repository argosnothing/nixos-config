{
  flake.modules.nixos.spotify-player = {
    hm = {
      programs.spotify-player = {
        enable = true;
        keymaps = [
          {
            command = "None";
            key_sequence = "q";
          }
        ];
      };
    };
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
