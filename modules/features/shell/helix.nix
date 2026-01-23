{
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [helix];
    my.quantum.directories = [
      ".config/helix"
    ];
  };
}
