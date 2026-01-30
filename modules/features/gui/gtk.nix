{
  flake.modules.nixos.gtk = {
    config,
    pkgs,
    lib,
    ...
  }: let
    icon-theme = config.my.icons;
    inherit (config.my) theme;
    inherit (config.my) cursor;
    inherit (config.my) fonts;
  in {
    environment.systemPackages = with pkgs; [
      lxappearance
      glib
      gsettings-desktop-schemas
      nwg-look
      pkgs.pywal
      pkgs.pywalfox-native
      pkgs.adw-gtk3
    ];
    environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [
      "${pkgs.gsettings-desktop-schemas}/share"
      "${pkgs.glib}/share"
    ];
    environment.pathsToLink = [
      "/share/gsettings-schemas"
    ];
  };
}
