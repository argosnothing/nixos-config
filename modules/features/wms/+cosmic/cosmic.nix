{
  flake.modules.nixos.cosmic = {pkgs, ...}: {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
    my.persist.home.directories = [
      ".config/cosmic"
      ".local/share/cosmic"
      ".local/state/cosmic"
      ".local/state/cosmic-comp"
    ];
    my.persist.root.directories = [
      "/var/lib/cosmic-greeter"
    ];
  };
}
