{
  flake.modules.nixos.krita = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [krita];
  };
}
