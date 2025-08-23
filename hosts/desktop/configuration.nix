{inputs, pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
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

  users.users.salivala = {
    isNormalUser = true;
    description = "Salivala";
    extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout"];
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
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
