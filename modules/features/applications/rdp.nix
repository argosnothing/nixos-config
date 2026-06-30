{
  flake.modules.nixos.rdp = {pkgs, ...}: {
    services.pcscd.enable = true;
    environment.systemPackages = with pkgs; [
      kdePackages.krdc
      opensc
      ccid
    ];
    my.persist = {
      home.cache.directories = [
        ".cache/remmina"
      ];
      home.directories = [
        # ".local/share/remmina"
        # ".config/remmina"
        ".local/share/krdc"
      ];
      home.files = [
        ".config/krdcrc"
        ".local/state/krdcstaterc"
        ".local/share/krdc"
      ];
    };
  };
}
