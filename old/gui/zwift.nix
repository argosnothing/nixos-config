{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (config.my.modules.gui.zwift) enable;
  inherit (lib) mkIf mkEnableOption;
in {
  imports = [inputs.zwift.nixosModules.zwift];
  options.my.modules.gui.zwift = {
    enable = mkEnableOption "Enable Zwift";
  };
  config = mkIf enable {
    my = {
      persist = {
        root = {
          directories = [
            "/var/lib/zwift"
            "/opt/wine-devel"
          ];
          cache.directories = [
            "/var/tmp"
          ];
        };
        home.directories = [
          ".local/share/containers"
        ];
      };
    };

    services.xserver = {
      enable = true;
      videoDrivers = ["nvidia"]; #nvidia suffices for those with newer gfx cards.
    };
    hardware = {
      graphics.enable32Bit = true;
      nvidia-container-toolkit.enable = true;
    };
    virtualisation = {
      podman = {
        enable = true;
      };
    };
    programs.zwift = {
      # Enable the Zwift module and install required dependencies
      enable = true;
      # The Docker image to use for Zwift
      image = "docker.io/netbrain/zwift";
      # The Zwift game version to run
      version = "1.67.0";
      # If true, do not pull the image (use locally cached image)
      dontPull = false;
      # If true, skip new version check
      dontCheck = false;
      # Container tool to run Zwift (e.g., "podman" or "docker")
      containerTool = "podman";
      # Zwift account username (email address)
      zwiftUsername = config.sops.secrets."zwift_credentials/email".path;
      # Zwift account password
      zwiftPassword = config.sops.secrets."zwift_credentials/password".path;
      # Directory to store Zwift workout files
      zwiftWorkoutDir = "/var/lib/zwift/workouts";
      # Directory to store Zwift activity files
      zwiftActivityDir = "/var/lib/zwift/activities";
      # Run Zwift in the foreground (set true for foreground mode)
      zwiftFg = false;
      # Disable Linux GameMode if true
      zwiftNoGameMode = false;
      # Enable Wine's experimental Wayland support if using Wayland
      wineExperimentalWayland = false;
      # Networking mode for the container ("bridge" is default)
      networking = "bridge";
      # User ID for running the container (usually your own UID)
      zwiftUid = "1000";
      # Group ID for running the container (usually your own GID)
      zwiftGid = "100";
      # GPU/device flags override (Docker: "--gpus=all", Podman/CDI: "--device=nvidia.com/gpu=all")
      vgaDeviceFlag = "--device=nvidia.com/gpu=all";
      # Enable debug output and verbose logging if true
      debug = false;
    };
  };
}
