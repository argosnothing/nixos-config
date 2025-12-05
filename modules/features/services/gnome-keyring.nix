{
  flake.modules.nixos.gnome-keyring = {
    services.gnome.gnome-keyring = {
      enable = true;
    };
    my.persist.home.directories = [".local/share/keyrings"];
  };
}
