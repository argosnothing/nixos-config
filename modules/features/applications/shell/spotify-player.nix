{
  flake.modules.nixos.spotify-player = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      spotify-player
    ];
  };
}
