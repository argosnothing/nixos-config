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
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    hm = _: {
      programs.niri.settings = {
        input = {
          mod-key = "Alt";
          mod-key-nested = "Super";
          mouse = {
            accel-speed = 0.3;
            accel-profile = "flat";
          };
        };
      };
    };
  };
}
