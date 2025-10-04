{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  mango-session = "/etc/wayland-sessions/mango.desktop";
in {
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
              enable = true;
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
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
    };
    environment.systemPackages = [
      pkgs.foot
      pkgs.wf-recorder
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.symbols-only
      pkgs.font-awesome
    ];
    programs.mango.enable = true;
  };
}
