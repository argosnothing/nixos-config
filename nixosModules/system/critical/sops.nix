{settings, ...}: {
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/persist/home/salivala/.config/sops/age/keys.txt";
    secrets = {
      ssh = {
        sopsFile = ../../../secrets/secrets.yaml;
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
      "myservice/my_subdir/my_secret" = {};
    };
  };
  environment.shellAliases = {
    secrets = "sops ${settings.absoluteflakedir}/secrets/secrets.yaml";
  };
}
