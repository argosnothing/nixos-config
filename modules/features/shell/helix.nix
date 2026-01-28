{
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      helix
      nixd
      nil
    ];
    quantum.directories = [
      ".config/helix"
    ];
  };
}
