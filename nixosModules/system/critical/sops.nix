{settings, ...}: {
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  #sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";
  sops.age.keyFile = "/persist/home/salivala/.config/sops/age/keys.txt";
  sops.secrets.ssh = {
    sopsFile = ../../../secrets/secrets.yaml;
    path = "/home/${settings.username}/.ssh/id_ed25519";
    owner = "${settings.username}";
    mode = "0600";
  };
  sops.secrets.example-key = {};
  sops.secrets.pc_password = {
    owner = "root";
    group = "root";
    mode = "0400";
    neededForUsers=true;
  };
  sops.secrets."myservice/my_subdir/my_secret" = {};
}
