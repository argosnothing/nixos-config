{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.modules.gui.nemo = {
    enable = mkEnableOption "Enable Nemo File Manager";
  };
  config = mkIf config.my.modules.gui.nemo.enable {
    hm = {pkgs, ...}: {
      home.packages = with pkgs; [
        nemo
      ];
    };
  };
}
