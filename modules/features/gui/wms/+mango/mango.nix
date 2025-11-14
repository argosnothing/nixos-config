{
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in{
  flake.modules.nixos.mango = {
    pkgs,
    lib,
    config,
    ...
  }: let
    mango-settings = builtins.concatStringsSep "\n" config.my.wm.mango.settings;
    nixos-modules = with flake.modules.nixos; [
      wm
      cursor
      icons
      gtk
    ];
  in {
    imports =
      [
        inputs.mango.nixosModules.mango
      ]
      ++ nixos-modules;
    my.session.exec-command = "${pkgs.dbus}/bin/dbus-run-session niri";
    programs.mango.enable = true;
    hj.files = {
      ".config/mango/autostart.sh".text = ''
        set +e
        dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1 &
        dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS >/dev/null 2>&1 &
        dbus-update-activation-environment --systemd DISPLAY &
         ${config.my.desktop-shells.execCommand} &
         ${lib.getExe pkgs.xwayland-satellite} :11 &
      '';
      ".config/mango/config.conf".text = mango-settings;
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = ["gtk"];
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };
    environment.systemPackages = [
      pkgs.glib
      pkgs.xdg-utils
      pkgs.wf-recorder
      pkgs.xwayland-satellite
    ];
  };
}
