{
  config,
  lib,
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.modules.shell.rtorrent) enable;
in {
  options.my.modules.shell.rtorrent = {
    enable = mkEnableOption "Enable Rtorrent";
  };
  config = mkIf enable {
    programs.rtorrent.enable = {
      enable = true;
    };
  };
}
