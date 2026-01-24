{
  flake.modules.nixos.misc = {
    config,
    pkgs,
    ...
  }: {
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

      variables = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1";
        ELECTRON_ENABLE_LOGGING = "0";
        EDITOR = "hx";
        VISUAL = "hx";
      };
    };
  };
}
