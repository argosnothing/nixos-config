{
  flake.modules.nixos.spotify-player = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      spotify-player
    ];
    my.persist = {
      home = {
        directories = [
          ".config/spotify-player"
        ];
        cache.directories = [
          ".cache/spotify-player"
        ];
      };
    };
  };
}
