{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.critical = {config, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = let
      secrets-location = "${self}/.secrets/secrets.yaml";
    in {
      defaultSopsFile = secrets-location;
      defaultSopsFormat = "yaml";
      age.keyFile =
        if config.my.persist.enable
        then "/persist/home/${config.user.name}/.config/sops/age/keys.txt"
        else "/home/${config.user.name}/.config/sops/age/keys.txt";
      secrets = {
        ssh = {
          sopsFile = secrets-location;
          path = "/home/${config.user.name}/.ssh/id_ed25519";
          owner = "${config.user.name}";
          mode = "0600";
        };
        github_token = {
          mode = "0400";
          owner = "${config.user.name}";
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
