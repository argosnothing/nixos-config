{
  pkgs,
  settings,
  config,
  lib,
  ...
}: let
  mango-settings = import ./settings {inherit config;};
in {
  imports = [
    ./waybar
    ./rofi
    ./scripts.nix
  ];
  config = lib.mkIf config.my.modules.gui.wms.mango.enable {
    hjem.users.${settings.username} = {
      packages = with pkgs; [
        pavucontrol
        swaynotificationcenter
        swaybg
        xorg.xrdb
        waybar
        (pkgs.writeShellScriptBin "setbg"
          ''
            swaybg -m stretch -i ${settings.absoluteflakedir}/media/current-wallpaper.png
          '')
      ];
      files = {
        ".config/mango/config.conf".text =
          mango-settings
          + ''
            env=QT_AUTO_SCREEN_SCALE_FACTOR,1
            env=QT_WAYLAND_FORCE_DPI,140
          '';
        ".config/mango/autostart.sh" = {
          executable = true;
          text = ''
            set +e
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
            swaync &
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
        };
      };
    };
  };
}
