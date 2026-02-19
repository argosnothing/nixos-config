{
  flake.modules.nixos.remmina = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      remmina
    ];
  };
}
