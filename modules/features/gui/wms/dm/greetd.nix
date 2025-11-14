{
  flake.modules.nixos.greetd = {
    pkgs,
    config,
    ...
  }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.my.session.exec-command}";
        user = "greeter";
      };
    };
  };
}
