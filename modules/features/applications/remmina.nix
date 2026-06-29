{
  flake.modules.nixos.remmina = {pkgs, ...}: {
    services.pcscd.enable = true;
    environment.systemPackages = with pkgs; [
      remmina
      opensc
      ccid
    ];
    my.persist = {
      home.cache.directories = [".cache/remmina"];
      home.directories = [
        ".local/share/remmina"
        ".config/remmina"
      ];
    };
  };
}
