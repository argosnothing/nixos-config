{
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      helix
      nixd
    ];
    quantum.directories = [
      ".config/helix"
    ];
  };
}
