{
  flake.modules.nixos.flatpak = {pkgs, ...}: {
    my.persist.home.directories = [
      ".var/app"
      ".local/share/flatpak"
    ];
    my.persist.root.directories = [
      "/var/lib/flatpak"
    ];
    services.flatpak = {
      enable = true;
    };
  };
}
