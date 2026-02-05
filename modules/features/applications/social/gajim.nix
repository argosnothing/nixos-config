{
  flake.modules.nixos.gajim = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [gajim];
    my.persist = {
      home.directories = [
        ".config/gajim"
        ".local/share/gajim"
      ];
      home.cache.directories = [".cache/gajim"];
    };
  };
}
