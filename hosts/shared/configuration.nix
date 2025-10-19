{
  inputs,
  pkgs,
  username,
  hostname,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./home.nix
    ../../modules
  ];

  # My Shared Modules
  my.modules = {
    critical = {
    };
    services = {
      pipewire.enable = true;
      gnome-keyring.enable = true;
    };
    style = {
      stylix.enable = true;
    };
    shell = {
      fish.enable = true;
      kitty.enable = true;
      starship.enable = true;
      yazi.enable = true;
      git.enable = true;
      zellij.enable = true;
    };
    gui = {
      firefox.enable = true;
      librewolf.enable = false;
      flatpak.enable = false;
      discord.enable = true;
      via.enable = true;
    };
  };

  nix = {
    settings = {
      trusted-users = ["${username}"];
      experimental-features = ["nix-command" "pipe-operators" "flakes"];
      download-buffer-size = 268435456;
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "niri.cachix.org-1:T+M3pBd3DkFdBvA+SviyNv0glk+rPZsAocRAGYMddww="
      ];
    };
    package = pkgs.nixVersions.latest;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  networking = {
    hostName = hostname;
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

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
