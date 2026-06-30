{
  flake.modules.nixos.audacity = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [audacity];
  };
}
