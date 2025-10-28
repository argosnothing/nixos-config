{inputs, ...}: {
  flake.modules.nixos.flatpak = {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
    xdg.portal.enable = true;
    my.persist.root.directories = ["/var/lib/flatpkak"];
    my.persist.home.directories = [
      ".local/share/bolt-launcher"
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
        "app.zen_browser.zen"
        "org.freedesktop.Platform.Compat.i386//23.08"
        "org.freedesktop.Platform.GL32.nvidia-580-76-05//1.4"
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
