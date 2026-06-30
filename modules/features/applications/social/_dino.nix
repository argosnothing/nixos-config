{
  flake.modules.nixos.dino = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      dino
    ];
  };
}
