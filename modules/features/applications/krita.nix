{
  flake.modules.nixos.krita = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [krita];
  };
}
