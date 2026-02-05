{
  flake.modules.nixos.kdenlive = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [kdePackages.kdenlive];
    my.persist = {
      home.directories = [
        ".local/share/kdenlive"
      ];
    };
  };
}
