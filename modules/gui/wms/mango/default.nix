{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.mango.nixosModules.mango
    ./config
  ];
  options = {
    my.gui.wms.mango.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mango WC as the window managerk";
    };
  };
  config = lib.mkIf (config.my.gui.wms.name == "mango") {
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
      wlr.enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    };
    environment.systemPackages = [
      pkgs.foot
      pkgs.wf-recorder
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.symbols-only
      pkgs.font-awesome
    ];
    wms.mango.enable = true;
    styles.stylix.enable = true;
    programs.mango.enable = true;
  };
}
