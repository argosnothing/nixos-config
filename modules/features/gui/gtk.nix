{
  flake.modules.nixos.gtk = {
    config,
    pkgs,
    ...
  }: let
    icon-theme = config.my.icons;
    inherit (config.my) theme;
    inherit (config.my) cursor;
    inherit (config.my) fonts;
  in {
    environment.systemPackages = with pkgs; [
      lxappearance
      nwg-look
      pkgs.pywal
      pkgs.pywalfox-native
      pkgs.adw-gtk3
    ];
    hj.rum.misc.gtk = {
      settings = {
        theme-name = "adw-gtk3";
        icon-theme-name = "breeze-dark";
        font-name = "Noto Sans  10";
        cursor-theme-name = "BreezeX-RosePine-Linux";
        cursor-theme-size = "24";
        toolbar-style = "GTK_TOOLBAR_ICONS";
        toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        button-images = 0;
        menu-images = 0;
        enable-event-sounds = 1;
        enable-input-feedback-sounds = 0;
        xft-antialias = 1;
        xft-hinting = 1;
        xft-hintstyle = "hintslight";
        xft-rgba = "rgb";
        application-prefer-dark-theme = true;
      };
      enable = true;
      packages = [
        pkgs.adw-gtk3
        cursor.package
        pkgs.arc-theme
        fonts.serif.package
        fonts.sans.package
        fonts.mono.package
      ];
    };
  };
}
