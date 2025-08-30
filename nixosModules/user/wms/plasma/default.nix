{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./panel.nix
    ./input.nix
  ];
  options = {
    wms.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma user configuration.";
    };
  };
  config = lib.mkIf config.wms.plasma.enable {
    home.packages = with pkgs; [
      pcmanfm-qt
      haruna
      kdePackages.yakuake
      kdePackages.kdeconnect-kde
      kdePackages.krfb
      easyeffects
    ];
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
    services.kdeconnect.enable = true;
    styles.stylix.enable = false; # less headache just turning this off for a full dektop environment. 
  };
}
