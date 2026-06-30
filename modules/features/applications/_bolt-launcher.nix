{
  flake.modules.nixos.bolt-launcher = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bolt-launcher
    ];
  };
}
