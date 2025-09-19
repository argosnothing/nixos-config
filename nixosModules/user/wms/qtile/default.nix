{
  pkgs,
  settings,
  config,
  lib,
  ...
}: {
  options = {
    wms.qtile.enable = lib.mkOption {
      type = lib.types.bool;
      defaults = false;
      description = "Enable Qtile for home";
    };
  };
  config = lib.mkIf (config.custom.wm.name == "qtile") {
    # xdg.configFile."qtile" = {
    #   source = "${settings.absoluteflakedir}/sources/qtile/";
    # };
    custom.persist.home.directories = [
      ".config/qtile"
    ];
  };
}
