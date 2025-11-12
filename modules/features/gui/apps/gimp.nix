{
  flake.modules.nixos.gimp = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [gimp];
  };
}
