{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.mango.nixosModules.mango
    ./service.nix
    ./config
  ];
  options = {
    my.modules.gui.wms.mango.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mango WC as the window managerk";
    };
  };
  config = lib.mkIf (config.my.modules.gui.wms.name == "mango") {
    programs.mango.enable = true;
    programs.wshowkeys.enable = true;
    my = {
      modules = {
        gui = {
          wms = {
            mango.enable = true;
            greeters.tuigreet = {
              enable = true;
              command = "dbus-run-session mango";
            };
          };
        };
      };
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
    ];
  };
}
