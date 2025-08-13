{ config, pkgs, ... }:

{
  imports = [ ./pipewire.nix ./dbus.nix ./gnome-keyring.nix ./fonts.nix ];

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
  };
  services.displayManager.sddm.extraPackages = with pkgs; [
    sddm-astronaut
  ];
  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
        themeConfig = {
          ScreenWidth = "1920";
          ScreenHeight = "1080";
          Font = config.stylix.fonts.sansSerif.name;
          FontSize = "12";

          RoundCorners = "20";

          #BackgroundPlaceholder = "${config.stylix.image}";
          #Background = "${config.stylix.image}";
          BackgroundSpeed = "1.0";
          PauseBackground = "";
          CropBackground = "false";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";

          PartialBlur = "true";
          BlurMax = "35";
          Blur = "2.0";

          HaveFormBackground = "false";
        };
      })
  ];
  services.xserver.enable = true;
}
