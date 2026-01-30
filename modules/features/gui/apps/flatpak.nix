{inputs, ...}: {
  flake.modules.nixos.flatpak = {pkgs, ...}: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
    xdg.portal.enable = true;
    my.persist.root.directories = ["/var/lib/flatpak"];
    my.persist.home.directories = [
      ".local/share/bolt-launcher"
      ".var/app"
      ".config/bolt-launcher"
    ];

    services.flatpak = {
      enable = true;

      # Custom remotes for packages not on Flathub
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      packages = [
      ];

      overrides = {
        global = {
          Context.filesystems = [
            "~/.themes:ro"
            "~/.icons:ro"
            "~/.local/share/icons:ro"
            "/usr/share/icons:ro"
            "/usr/share/themes:ro"
            "/nix/store:ro"
          ];
          Environment = {
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons:/usr/share/icons";
            XCURSOR_THEME = "Qogir";
            XCURSOR_SIZE = "24";
          };
        };
      };
    };
  };
}
