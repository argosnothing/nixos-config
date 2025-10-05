{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.modules.gui.discord = {
    enable = mkEnableOption "Enable Discord";
  };
  config = mkIf config.my.modules.gui.discord.enable {
    hm = _: {
      programs = {
        vesktop = {
          enable = true;
          settings = {
            hardwareAcceleration = false;
          };
        };
      };
      my.persist.home.directories = [
        ".config/discord"
        ".config/vencord"
        ".config/vesktop"
      ];
    };
  };
}
