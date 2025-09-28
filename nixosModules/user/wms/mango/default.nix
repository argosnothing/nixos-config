# This file is going to be a mess for a bit as i configure mango
{
  pkgs,
  config,
  lib,
  settings,
  inputs,
  ...
}: let
  mango-settings = import ./settings {inherit config;};
in {
  imports = [
    ./config
    inputs.mango.hmModules.mango
  ];
  options = {
    wms.mango.enable = lib.mkEnableOption "Enable Mango";
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    wms.mango.enable = true;
    styles.stylix.enable = true;
    stylix.targets.rofi.enable = false;
    services.swaync.enable = true;
    #custom.desktop-shell.name = "noctalia-shell"; # Hopefully i get this working one day?
    home.packages = with pkgs; [
      pavucontrol
      swaybg
      xorg.xrdb
      (pkgs.writeShellScriptBin "setbg"
        ''
          swaybg -m stretch -i ${settings.absoluteflakedir}/media/current-wallpaper.jpg
        '')
    ];
    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = ''
        set +e
        setbg &
        waybar &
        echo "Xft.dpi:140" | xrdb -merge
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
        # cursor size
        cursor_size=24
        env=XCURSOR_SIZE,24

        # fcitx5 im
        env=GTK_IM_MODULE,fcitx
        env=QT_IM_MODULE,fcitx
        env=SDL_IM_MODULE,fcitx
        env=XMODIFIERS,@im=fcitx
        env=GLFW_IM_MODULE,ibus

        # scale factor about qt (herr is 1.4)
        env=QT_QPA_PLATFORMTHEME,qt5ct
        env=QT_AUTO_SCREEN_SCALE_FACTOR,1
        env=QT_QPA_PLATFORM,Wayland;xcb
        env=QT_WAYLAND_FORCE_DPI,140
      '';
      settings =
        ''
          env=QT_AUTO_SCREEN_SCALE_FACTOR,1
          env=QT_WAYLAND_FORCE_DPI,140
        ''
        + mango-settings;
    };
  };
}
