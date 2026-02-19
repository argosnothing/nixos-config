{
  flake.modules.nixos.cinny = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [cinny-desktop];
  };
}
