{
  pkgs,
  settings,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my.modules.gui.wms) mango;
in {
  config = mkIf mango.enable {
    systemd.user.services.mango = {
      description = "Mango Session";
      after = ["graphical-session-pre.target"];
      wantedBy = ["graphical-session.target"];

      environment = {
        XDG_CURRENT_DESKTOP = "wlroots";
        XDG_SESSION_TYPE = "wayland";
      };

      serviceConfig = {
        ExecStart = "${pkgs.mango}/bin/mango";
        Restart = "on-failure";
      };
    };
  };
}
