{
  flake.modules.nixos.krita = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [krita];
    my.persist = {
      home.directories = [
        ".local/share/krita"
      ];
    };
  };
}
