{
  flake.modules.nixos.compositor-service = {
    lib,
    config,
    ...
  }: let
    inherit (config.my.session) name;
  in {
    systemd.user.targets."${name}-session" = {
      unitConfig = {
        Description = "${lib.strings.toSentenceCase name} compositor session";
        BindsTo = ["graphical-session.target"];
        Wants = ["graphical-session-pre.target"];
        After = ["graphical-session-pre.target"];
      };
      wantedBy = ["graphical-session.target"];
    };
  };
}
