# I like the idea of plasma manager, but plasma overall has been giving me issues, so i'd rather figure that out before using this. 
{
  lib,
  inputs,
  config, 
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./panel.nix
    ./input.nix
  ];
  options = {
    wms.plasma.plasmaManager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma Manager user configuration.";
    };
  };
  config = lib.mkIf config.wms.plasma.plasmaManager.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = true;
      
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        colorScheme = "BreezeDark";
        theme = "breeze-dark";
      };
      
      kwin.virtualDesktops = {
        number = 4;
        names = [ "Desktop 1" "Desktop 2" "Desktop 3" "Desktop 4" ];
      };
      
      hotkeys.commands = {
        launch-discord = {
          name = "Launch Discord";
          key = "Alt+Q";
          command = "discord";
        };
      };
    };
  };
}