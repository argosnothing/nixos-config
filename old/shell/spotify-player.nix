{
  config,
  lib,
  ...
}: {
  options.my.modules.shell.spotify-player = {
    enable = lib.mkEnableOption "Enable Terminal Spotify";
  };
  config = lib.mkIf config.my.modules.shell.spotify-player.enable {
    hm = _: {
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
