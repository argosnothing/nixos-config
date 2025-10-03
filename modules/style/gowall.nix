{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf generators;
  inherit (generators) toYAML;
in {
  options.my.modules.style.gowall = {
    enable = mkEnableOption "Go wall!";
  };
  config = mkIf config.my.modules.gui.gowall.enable {
    environment.systemPackages = with pkgs; [
      gowall
    ];
    hj = {
      files = {
        ".config/gowall/config.yml" = {
          generator = toYAML {};
          value = {
            themes = {
              name = "occult";
              colors = [
                "#14141E"
                "#1E1E2A"
                "#252533"
                "#2F2F3E"
                "#3C3C4E"
                "#6270A8" 
                "#8E6BAE" 
                "#C25B5B" 
                "#E08A66" 
                "#E6C27A" 
                "#8BAA82" 
                "#95B3B0" 
                "#ADC9C7" 
                "#B78FB3" 
                "#F2EADF" 
                "#FFF8F2" 
                "#A1C49A" 
                "#F5DCA0" 
                "#7C89BA" 
                "#B86C6A" 
              ];
            };
          };
        };
      };
    };
  };
}
