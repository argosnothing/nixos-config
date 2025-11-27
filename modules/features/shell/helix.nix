{
  flake.modulees.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [helix];
  };
}
