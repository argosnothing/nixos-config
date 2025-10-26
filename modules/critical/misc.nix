{
  flake.modules.nixos.critical = {
    config,
    pkgs,
    ...
  }: {
    networking = {
      hostName = config.my.hostname;
      networkmanager.enable = true;
      nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    };

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    my.persist.root.directories = [
      "/etc/NetworkManager/system-connections"
    ];

    environment = {
      shells = with pkgs; [zsh];

      systemPackages = with pkgs; [
        # criticals
        sops
        dbus
        hdparm

        # must haves
        bottom
        nh
        lazygit
        alejandra
        git
        unzip
        openssl
        usbutils

        # audios
        pipewire
        pamix
        grimblast
        playerctl

        # others
        brightnessctl
      ];

      # Environment variables for Electron apps
      sessionVariables = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1"; # Enable Wayland for Electron apps
        ELECTRON_ENABLE_LOGGING = "0"; # Reduce verbose output
        EDITOR = "vim";
        VISUAL = "vim";
      };
    };
  };
}
