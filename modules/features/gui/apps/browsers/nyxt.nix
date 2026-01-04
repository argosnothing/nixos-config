{
  flake.modules.nixos.nyxt = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nyxt
    ];
  };
}
