{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    #inputs.plasma-manager.homeManagerModules.plasma-manager
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
   #programs.plasma = {
   #  enable = true;
   #  hotkeys.commands = {
   #    launch-discord = {
   #      name = "Launch Discord";
   #      key = "Alt+Q";
   #      command = "discord";
   #    };
   #  };
   #};
    services.kdeconnect.enable = true;
    styles.stylix.enable = false;
  };
}
