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
    # CREDIT: 
    # https://github.com/iynaix/dotfiles/blob/a494fec53ac1441ea78a9014564eb24f4724a285/modules/gui/mango/default.nix#L4
    systemd.user.targets.mango-session = {
      unitConfig = {
        Description = "mango compositor session";
        Documentation = ["man:systemd.special(7)"];
        BindsTo = ["graphical-session.target"];
        Wants = [
          "graphical-session-pre.target"
        ];
        # ++ lib.optional cfg.systemd.xdgAutostart "xdg-desktop-autostart.target";
        After = ["graphical-session-pre.target"];
        # Before = lib.optional cfg.systemd.xdgAutostart "xdg-desktop-autostart.target";
      };
    };
  };
}
