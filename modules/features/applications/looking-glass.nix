{
  flake.modules.nixos.looking-glass = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      looking-glass-client
    ];
  };
}
