{
  pkgs,
  lib,
  config,
  settings,
  ...
}: {
  options = {
    wms.dwl.enable = lib.mkEnableOption "Enable User DWL";
  };
  config = lib.mkIf (config.custom.wm.name == "dwl") {
    styles.stylix.enable = true;
    custom.apps = {
      wmenu.enable = true;
    };
    systemd.user.services.setbg = {
      Unit = {
        Description = "Set Wallpaper";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "setbg";
        Environment = ["XDG_RUNTIME_DIR=%t"];
      };
    };
    systemd.user.paths."setbg-on-wayland" = {
      Unit.Description = "Run setbg when a wayland socket comes up";
      Path.PathExistsGlob = "%t/wayland-*";
      Install.WantedBy = ["default.target"];
      Path.Unit = "setbg.service";
    };
    home.packages = with pkgs; [
      swaybg
      (pkgs.writeShellScriptBin "setbg"
        ''
          swaybg -m stretch -i ${settings.absoluteflakedir}/media/current-wallpaper.jpg
        '')
    ];
  };
}
