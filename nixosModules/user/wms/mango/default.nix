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
