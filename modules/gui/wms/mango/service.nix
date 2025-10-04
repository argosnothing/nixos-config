{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.my.modules.gui.wms) mango;
  inherit (pkgs) system;
  mango-package = inputs.mango.packages.${system}.default;
in {
  config = mkIf mango.enable {
    environment.etc."wayland-sessions/mango.desktop".text = ''
      [Desktop Entry]
      Name=Mango
      Comment=Mango Wayland compositor
      Exec=${getExe mango-package}
      Type=Application
    '';
    systemd.user.services.mango = {
      description = "Mango compositor";
      partOf = ["wayland-session.target"];
      after = ["graphical-session.target"];
      wantedBy = ["wayland-session.target"];

      serviceConfig = {
        ExecStart = getExe mango-package;
        Restart = "on-failure";
        Environment = [
          "XDG_SESSION_TYPE=wayland"
          "XDG_CURRENT_DESKTOP=mango"
          "XDG_SESSION_DESKTOP=mango"
        ];
      };
    };
  };
}
