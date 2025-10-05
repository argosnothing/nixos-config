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
    my = {
      modules = {
        gui = {
          wms = {
            mango.enable = true;
            greeters.tuigreet = {
              enable = false;
              command = "mango";
            };
          };
          gtk.enable = true;
        };
      };
    };
    fonts = {
      fontconfig.enable = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.symbols-only
        font-awesome
      ];
    };
    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "wlroots";
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      config.common = {
        default = ["gnome"];
      };
      config.mango = {
        default = "gnome";
      };
    };
    environment.systemPackages = [
      pkgs.glib
      pkgs.xdg-utils
      pkgs.wf-recorder
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.symbols-only
      pkgs.font-awesome
    ];
    programs.mango.enable = true;
  };
}
