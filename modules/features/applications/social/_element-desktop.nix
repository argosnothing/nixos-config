{
  flake.modules.nixos.element-desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      element-desktop
    ];
  };
}
