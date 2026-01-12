{
  flake.modules.nixos.networking = {
    pkgs,
    config,
    ...
  }: {
    networking = {
      hostName = config.my.hostname;
      networkmanager.enable = true;
      nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    };

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
