{
  flake.modules.nixos.ventoy = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ventoy-full-gtk
    ];
  };
}
