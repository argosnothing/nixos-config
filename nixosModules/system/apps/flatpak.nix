{
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    systemFlatpak.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "System Flatpak support.";
    };
  };

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];
  config = lib.mkIf config.systemFlatpak.enable {
    xdg.portal.enable = true;

    services.flatpak = {
      enable = true;

      # Custom remotes for packages not on Flathub
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
        {
          name = "JagexLauncher";
          location = "https://jagexlauncher.flatpak.mcswain.dev/JagexLauncher.flatpakrepo";
        }
      ];

      packages = [
        #"com.valvesoftware.Steam"
        {
          appId = "com.jagex.Launcher";
          origin = "JagexLauncher";
        } # Official Jagex Launcher
        {
          appId = "com.jagex.Launcher.ThirdParty.RuneLite";
          origin = "JagexLauncher";
        } # RuneLite from Jagex Launcher remote
        "org.freedesktop.Platform.Compat.i386//23.08" # 32-bit compat extension for Jagex Launcher
        "org.freedesktop.Platform.GL32.nvidia-580-76-05//1.4" # 32-bit NVIDIA OpenGL drivers for Steam
      ];

      overrides = {
       #"com.valvesoftware.Steam" = {
       #  Context.filesystems = [
       #    "~/.themes:ro"
       #    "~/.icons:ro"
       #    "~/.local/share/icons:ro"
       #    "/usr/share/icons:ro"
       #    "/usr/share/themes:ro"
       #  ];
       #};
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
            # Ensure cursor theme is available
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons:/usr/share/icons";
            XCURSOR_THEME = "Qogir";
            XCURSOR_SIZE = "24";
          };
        };
      };
    };
  };
}
