{
  flake.modules.nixos.claude-code = {pkgs, ...}: {
    environment.systemPackages = [pkgs.claude-code];
  };
}
