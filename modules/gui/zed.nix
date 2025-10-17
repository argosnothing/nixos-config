{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.modules.gui) zed;
in {
  options.my.modules.gui.zed = {
    enable = mkEnableOption "Enable Zed";
  };
  config = mkIf zed.enable {
    environment.systemPackages = with pkgs; [zed-editor-fhs];
  };
}
