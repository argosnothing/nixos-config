{inputs, pkgs, settings, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../nixosModules/system/wm/hyprland.nix
    ../../nixosModules/system/wm/login.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  boot.plymouth.enable = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = ["nodev"];
  };
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "desktop";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users."${settings.username}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
  };

  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  environment.systemPackages = with pkgs; [
    vim
    git
    gitkraken
    unzip
    openssl
    home-manager
    pavucontrol
    # Audio control utilities
    wireplumber
    pipewire
    # Screenshot utilities
    grimblast
    # Screen brightness control
    brightnessctl
    # Media control
    playerctl
    # Screen locker dependencies
    swayidle
    # Wayland session utilities
    dbus
  ];

  # Enable missing services that are causing errors
  security.rtkit.enable = true;  # RealtimeKit for audio/video performance
  services.upower.enable = true; # UPower for power management
  services.dbus.enable = true;   # D-Bus system message bus
  
  # Fix seat management for Wayland sessions
  services.seatd.enable = true;
  
  # Audio services
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
