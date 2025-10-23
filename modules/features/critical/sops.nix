{
  config,
  self,
  ...
}: {
  flake.modules.nixos.critical = let
    inherit (config.flake.settings) username;
    inherit (config.flake.settings) persist;
    in{
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile =
        if persist.enable
        then "/persist/home/${username}/.config/sops/age/keys.txt"
        else "/home/${username}/.config/sops/age/keys.txt";
      secrets = {
        ssh = {
          sopsFile = ../../secrets/secrets.yaml;
          path = "/home/${username}/.ssh/id_ed25519";
          owner = "${username}";
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
      secrets = "sops ${self}/secrets/secrets.yaml";
    };
  };
}
