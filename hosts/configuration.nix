{
  inputs,
  pkgs,
  config,
  settings,
  lib,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" settings.username])
    ../nixosModules/system/critical
    ../nixosModules/system
  ];
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nixVersions.latest;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings.download-buffer-size = 268435456;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  networking = {
    hostName = settings.hostname;
    networkmanager.enable = true;
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  users = {
    users.root.initialPassword = "password";
    #users.mutableUsers = false;
    users."${settings.username}" = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
      hashedPasswordFile = config.sops.secrets."pc_password".path;
      # initialPassword = "password";
    };
    defaultUserShell = pkgs.zsh;
  };
  environment = {
    # Shell configuration
    shells = with pkgs; [zsh];

    # Core system packages
    systemPackages = with pkgs; [
      nh
      lazygit
      alejandra
      fastfetch
      sops
      hdparm
      git
      gitkraken
      unzip
      openssl
      usbutils
      pipewire
      grimblast
      brightnessctl
      dbus
      home-manager
      unetbootin
    ];

    # Environment variables for Electron apps
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1"; # Enable Wayland for Electron apps
      ELECTRON_ENABLE_LOGGING = "0"; # Reduce verbose output
    };
  };
  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
