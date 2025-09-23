{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.mango.nixosModules.mango];
  options = {
    wms.mango.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mango WC as the window managerk";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "mango") {
    fonts = {
      fontconfig.enable = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        nerd-fonts.symbols-only
        font-awesome
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
    wms.mango.enable = true;
    styles.stylix.enable = true;
    programs.mango.enable = true;
  };
}
