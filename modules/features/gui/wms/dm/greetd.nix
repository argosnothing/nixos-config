{
  flake.modules.nixos.greetd = {pkgs, config, ...}: {
    services.greetd = {
      enable = true;
      default_session = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.my.session.exec-command}";
    };
  };
}
