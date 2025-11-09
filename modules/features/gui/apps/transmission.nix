{
  flake.nixos.modules.transmission = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      transmission_4-gtk
    ];
    my.persist.home = {
      directories = [
        ".config/transmission"
      ];
      cache.directories = [
        ".cache/transmission"
      ];
    };
  };
}
