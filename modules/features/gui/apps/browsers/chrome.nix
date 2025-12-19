{
  flake.modules.nixos.chrome = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };
}
