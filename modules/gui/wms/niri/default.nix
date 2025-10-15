{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) bool;
in {
  imports = [
    inputs.niri.nixosModules.niri
    ./config
  ];
  options = {
    my.modules.gui.wms.niri.enable = mkOption {
      type = bool;
      default = false;
      description = "Enable Niri";
    };
  };
  config = mkIf (config.my.modules.gui.wms.name == "niri") {
    my = {
      modules = {
        gui = {
          wms = {
            niri.enable = true;
            cursor.enable = true;
            greeters.tuigreet = {
              enable = true;
              command = "niri-session";
            };
          };
          desktop-shells.name = "noctalia-shell";
        };
      };
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = "gtk gnome";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
        niri.default = [
          "gtk"
          "gnome"
          "wlr"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    hm = {
      programs.niri.settings = {
        input = {
          focus-follows-mouse.enable = false;
          warp-mouse-to-focus.enable = false;
          mod-key = "Alt";
          mod-key-nested = "Super";
          mouse = {
            accel-speed = 0.3;
            accel-profile = "flat";
          };
          touchpad = {
            dwt = true;
            scroll-factor = 0.5;
          };
        };
      };
    };
  };
}
