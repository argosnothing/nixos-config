{
  pkgs,
  config,
  lib,
  ...
}: {
  options.my.modules.shell.spotify-player = {
    enable = lib.mkEnableOption "Enable Terminal Spotify";
  };
  config = lib.mkIf config.my.modules.shell.spotify-player.enable {
    environment.systemPackages = with pkgs; [spotify-player];
  };
  my.persist = {
    home.directories = [
      ".config/spotify-player"
    ];
  };
  hj = {
  };
}
