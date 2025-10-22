{
  pkgs,
  config,
  lib,
  self,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.modules.gui) zed;
in {
  options.my.modules.gui.zed = {
    enable = mkEnableOption "Enable Zed";
  };
  config = mkIf zed.enable {
    environment.systemPackages = [
      self.packages.${pkgs.system}.zeditor
    ];
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
