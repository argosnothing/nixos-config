{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.cinnamon = {pkgs, ...}: {
    imports = with flake.modules.nixos; [
      lightdm
    ];
    services.xserver = {
      enable = true;
      desktopManager.cinnamon.enable = true;
    };
    my.persist = {
      home = {
        directories = [
          ".config/cinnamon"
          ".local/share/cinnamon"
          ".config/dconf"
          ".local/share/gnome-settings-daemon"
          ".local/share/keyrings"
          ".config/gtk-3.0"
          ".config/gtk-4.0"
          ".local/share/evolution"
          ".local/share/gvfs-metadata"
          ".local/share/mime"
          ".config/evolution"
        ];
      };
    };
  };
}
