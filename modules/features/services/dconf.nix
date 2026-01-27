{
  flake.modules.nixos.dconf = {
    lib,
    pkgs,
    config,
    ...
  }: let
    mkIniKeyValue = key: value: "${key}=${toString (lib.gvariant.mkValue value)}";
    toDconfIni = lib.generators.toINI {mkKeyValue = mkIniKeyValue;};

    settings = config.my.dconf.settings or {};

    iniDrv = pkgs.writeText "dconf.ini" (toDconfIni settings);
    iniPath = ".config/hjem/dconf.ini";
  in {
    options.my.dconf.settings = lib.mkOption {
      type = with lib.types; attrsOf (attrsOf lib.gvariant.type);
      default = {};
      description = "Dconf settings (dir -> { key = gvariant value; }).";
    };

    config = lib.mkIf (settings != {}) {
      environment.systemPackages = [pkgs.dconf pkgs.dbus];

      hj = {
        packages = [pkgs.dconf pkgs.dbus];

        files.${iniPath}.source = iniDrv;

        systemd.enable = true;

        systemd.services."dconf-apply" = {
          description = "Apply dconf from ${iniPath}";
          path = [pkgs.dconf pkgs.dbus];

          script = ''
            set -euo pipefail
            if [[ -n "''${DBUS_SESSION_BUS_ADDRESS-}" ]]; then
              dconf load / < "$HOME/${iniPath}"
            else
              dbus-run-session -- dconf load / < "$HOME/${iniPath}"
            fi
          '';

          serviceConfig.Type = "oneshot";
          wantedBy = ["default.target"];

          # Re-run when the generated ini changes between rebuilds
          restartTriggers = [iniDrv];
        };
      };
    };
  };
}
