{
  flake.modules.nixos.kdenlive = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [kdePackages.kdenlive];
  };
}
