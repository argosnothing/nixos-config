{
  flake.modules.nixos.dino = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      dino
    ];
    my.persist.home.directories = [
      ".local/share/dino" ];
  };
}
