{
  pkgs,
  lib,
  config,
  inputs,
  settings,
  ...
}: {
  options = {
    wms.dwl.enable = lib.mkEnableOption "Enable System DWL Session";
  };

  config = lib.mkIf (config.custom.wm.name == "dwl") {
    wms.dwl.enable = true;
    styles.stylix.enable = true;
    custom.greeters.tuigreet = {
      enable = true;
      run-command = "dwl";
    };
    programs.dwl = {
      enable = true;
      package = pkgs.dwl.overrideAttrs (next: prev: {
        src = inputs.dwl;
        buildInputs = prev.buildInputs ++ [pkgs.wlroots_0_19];
      });
    };
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    services = {
      xserver.excludePackages = [pkgs.xterm];
    };
  };
}
