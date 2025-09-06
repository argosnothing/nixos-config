{
  pkgs,
  input,
  settings,
  config,
  lib,
  ...
}: {
  option = {
    mpv.enable = lib.mkEnableOption "Enable mpv media player";
  };

  config = lib.mkIf config.mpv.enable {
    home.packages = with pkgs; [
      mpv
      yt-dlp
      streamlink
      ffmpeg
    ];
  };
}
