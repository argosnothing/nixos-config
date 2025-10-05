{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.mango.nixosModules.mango
    {programs.mango.enable = true;}
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
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
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
  };
}
