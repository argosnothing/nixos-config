{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    userFlatpak.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "User Flatpak support.";
    };
  };
  config = lib.mkIf config.userFlatpak.enable {
    home.packages = [pkgs.flatpak];
    home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"; # lets flatpak work
    };
  };
}