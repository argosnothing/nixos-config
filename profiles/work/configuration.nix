{ config, pkgs, userSettings, ... }:

{
  imports = [
    #../../system/app/remote_tooling.nix
    ../../system/app/flatpak.nix
    ../../hardware-configuration.nix
    (./. + "../../../system/wm"+("/"+userSettings.wm)+".nix")
    ../../system/style/stylix.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # --- GPU (NVIDIA) ---
  hardware.graphics.enable = true;        # replaces old hardware.opengl.enable
  services.xserver.videoDrivers = [ "nvidia" ];
  #services.flatpak.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- Basics ---
  boot.plymouth.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=false"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0"   # optional, hides blinking cursor
    "console=tty12"                 # send kernel logs to tty12 instead of tty1
  ];
  boot.kernel.sysctl."kernel.printk" = "3 3 3 3";


  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";


  #systemd.services.greetd.serviceConfig.Type = "idle";
  #services.greetd = {
  # enable = true;
  # vt = 1;
  # package = pkgs.tuigreet;
  # settings.default_session = {
 #    user = "salivala";
 #    command = "tuigreet --time --remember --cmd 'bash -lc Hyprland'";
 #  };
 #};

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  # --- User ---
  users.users.salivala = {
    isNormalUser = true;
    description = "Salivala";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
	  vim
    wget
	  git
	  wev
	  unzip
    openssl
    home-manager
    pavucontrol
    playerctl
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";
}

