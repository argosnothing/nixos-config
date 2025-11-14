{inputs, ...}: {
  flake.modules.nixos.mango = {config, ...}: let
    mango-settings = builtins.concatStringsSep "\n" config.my.wm.mango.settings;
  in {
    environment.sessionVariables.GTK_USE_PORTAL = "1";
    hm = {
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.mango.hmModules.mango
      ];
      services.swaync.enable = true;
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config.common.default = ["gtk"];
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          xdg-desktop-portal
        ];
      };
      wayland.windowManager.mango = {
        enable = true;
        settings = mango-settings;
        autostart_sh = ''
          # set +e
          # dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1 &
          # dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS >/dev/null 2>&1 &
          # dbus-update-activation-environment --systemd DISPLAY &
            ${config.my.desktop-shells.execCommand} &
            ${lib.getExe pkgs.xwayland-satellite} :11 &
          # echo "Xft.dpi:140" | xrdb -merge
          # gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
        '';
      };
    };
  };
}
