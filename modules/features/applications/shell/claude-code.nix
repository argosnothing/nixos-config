{
  flake.modules.nixos.claude-code = {
    # pkgs,
    pkgs-stable,
    ...
  }: {
    environment.systemPackages = [pkgs-stable.claude-code];
  };
}
