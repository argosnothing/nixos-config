{
  flake.modules.nixos.audacity = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [audacity];
    my.persist = {
      home.directories = [
        ".audacity-data"
      ];
    };
  };
}
