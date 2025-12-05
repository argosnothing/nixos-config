{
  flake.modules.nixos.gnome-keyring = {pkgs, ...}: {
    services.gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
    my.persist.home.directories = [".local/share/keyrings"];
  };
}
