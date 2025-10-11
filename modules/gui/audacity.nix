{
pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.my.modules.gui.audacity) enable;
in {
  options.my.modules.gui.audacity = {
    enable = mkEnableOption "Audacity";
  };
  config = mkIf enable {
    environment.systemPackages = with pkgs; [audacity];
    my.persist = {
      home.directories = [
        ".audacity-data"
      ];
    };
  };
}
