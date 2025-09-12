{settings, ...}: {
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";
  sops.secrets.ssh = {};
  sops.secrets.example-key = {};
  sops.secrets."pc_password" = {};
  sops.secrets."myservice/my_subdir/my_secret" = {};
}
