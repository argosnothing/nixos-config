{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wms.qtile.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Qtile as the window manager";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "qtile") {
    wms.qtile.enable = true;
    styles.stylix.enable = true;
    custom.greeters.tuigreet = {
      enable = true;
      run-command = "qtile";
    };
    services = {
      xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages:
          with python3Packages; [
            qtile-extras
          ];
      };
    };
  };
}
