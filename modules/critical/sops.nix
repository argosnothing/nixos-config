{
  settings,
  config,
  ...
}: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile =
      if config.my.persist.enable
      then "/persist/home/${settings.username}/.config/sops/age/keys.txt"
      else "/home/${settings.username}/.config/sops/age/keys.txt";
    secrets = {
      ssh = {
        sopsFile = ../../secrets/secrets.yaml;
        path = "/home/${settings.username}/.ssh/id_ed25519";
        owner = "${settings.username}";
        mode = "0600";
      };
      example-key = {};
      pc_password = {
        owner = "root";
        group = "root";
        mode = "0400";
        neededForUsers = true;
      };
      "zwift_credentials/email" = {};
      "zwift_credentials/password" = {};
      "myservice/my_subdir/my_secret" = {};
    };
  };
  environment.shellAliases = {
    secrets = "sops ${settings.absoluteflakedir}/secrets/secrets.yaml";
  };
}
