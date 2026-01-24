{
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      helix
      nixd
    ];
    my.quantum.directories = [
      ".config/helix"
    ];
  };
}
