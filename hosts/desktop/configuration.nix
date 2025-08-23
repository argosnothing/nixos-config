{
  inputs,
  pkgs,
  pkgsUnstable,
  settings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../nixosModules/system/wm/hyprland.nix
    ../../nixosModules/system/misc/remote_tooling.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  boot.plymouth.enable = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = ["nodev"];
  };
  boot.loader.grub.theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=false"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0" # optional, hides blinking cursor
  ];
  boot.kernel.sysctl."kernel.printk" = "3 3 3 3";

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
    wireplumber
    pipewire
    grimblast
    brightnessctl
    playerctl
    swayidle
    dbus
  ];

  # Enable missing services that are causing errors
  services.upower.enable = true; # UPower for power management
  services.dbus.enable = true; # D-Bus system message bus

  # Fix seat management for Wayland sessions
  services.seatd.enable = true;

  # Audio services
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Environment variables for Electron apps
  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1"; # Enable Wayland for Electron apps
    ELECTRON_ENABLE_LOGGING = "0"; # Reduce verbose output
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
