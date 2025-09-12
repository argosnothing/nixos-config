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
    ../nixosModules/system/critical
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${settings.username}/.config/sops/age/keys.txt";
  sops.secrets.ssh = {};
  sops.secrets.example-key = {};
  sops.secrets."pc_password" = {};
  sops.secrets."myservice/my_subdir/my_secret" = {};

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nixVersions.latest;

  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    dnsovertls = "true";
  };
  services.mullvad-vpn.enable = true;

  # Locale and time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # User configuration
  users.users."${settings.username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
    hashedPasswordFile = config.sops.secrets.pc_password.path;
  };

  # Shell configuration
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Core system packages
  environment.systemPackages = with pkgs; [
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
  ];

  # Environment variables for Electron apps
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1"; # Enable Wayland for Electron apps
    ELECTRON_ENABLE_LOGGING = "0"; # Reduce verbose output
  };

  system.stateVersion = "25.05";
}
