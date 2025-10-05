{
  config,
  settings,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.modules.gui.chrome = {
    enable = mkEnableOption "Google Chrome";
  };
  config = mkIf config.my.modules.gui.chrome.enable {
    hm = _: {
      programs.google-chrome.enable = true;
    };
  };
}
