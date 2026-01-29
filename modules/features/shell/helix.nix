{
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      helix
      nixd
      nil
      lldb
    ];
    quantum.directories = [
      ".config/helix"
    ];
  };
}
