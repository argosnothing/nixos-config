{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
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
    services.kdeconnect.enable = true;
    styles.stylix.enable = false; # less headache just turning this off for a full dektop environment. 
  };
}
