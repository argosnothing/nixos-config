{
  flake.modules.nixos.transmission = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      transmission_4-gtk
    ];
  };
}
