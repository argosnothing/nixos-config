{
  flake.modules.nixos.obs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
