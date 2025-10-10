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
      };
    };
    my.persist = {
      home.directories = [
        ".config/spotify-player"
      ];
    };
  };
}
