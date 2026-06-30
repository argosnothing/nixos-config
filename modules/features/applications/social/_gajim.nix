{
  flake.modules.nixos.gajim = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [gajim];
  };
}
