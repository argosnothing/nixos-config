{
  flake.modules.nixos.lightdm = {...}: {
    services.xserver.displayManager.lightdm.enable = true;
    # ly stores its state in /var/lib/ly — lightdm equivalent below
    my.persist.root.directories = [
      "/var/lib/lightdm"
      "/var/cache/lightdm"
    ];
  };
}
