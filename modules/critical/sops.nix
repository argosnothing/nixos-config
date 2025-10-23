{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos.critical = {config, self, ...}: {
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile =
        if config.impermanence.enable
        then "/persist/home/${config.user.name}/.config/sops/age/keys.txt"
        else "/home/${config.user.name}/.config/sops/age/keys.txt";
      secrets = {
        ssh = {
          sopsFile = ../../secrets/secrets.yaml;
          path = "/home/${config.user.name}/.ssh/id_ed25519";
          owner = "${config.user.name}";
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
