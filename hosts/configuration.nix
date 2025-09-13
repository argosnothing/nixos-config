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
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nixVersions.latest;

  networking.hostName = settings.hostname;
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.root.initialPassword = "password";
  users.mutableUsers = false;
  users.users."${settings.username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
    initialPassword = "password";
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
    unetbootin
  ];

  # Environment variables for Electron apps
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1"; # Enable Wayland for Electron apps
    ELECTRON_ENABLE_LOGGING = "0"; # Reduce verbose output
  };

  system.stateVersion = "25.05";
}
