{
  flake.modules.nixos.flatpak = {
    pkgs,
    lib,
    config,
    ...
  }: {
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

    environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [
      "var/lib/flatpak/exports/share"
      "/home/${config.my.username}/.local/share/flatpak/exports/share"
    ];
  };
}
