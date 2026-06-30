{
  flake.modules.nixos.flatpak = {
    pkgs,
    lib,
    config,
    ...
  }: {
    services.flatpak = {
      enable = true;
    };

    environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [
      "var/lib/flatpak/exports/share"
      "/home/${config.my.username}/.local/share/flatpak/exports/share"
    ];
  };
}
