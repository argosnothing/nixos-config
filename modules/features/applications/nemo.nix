{
  flake.modules.nixos.nemo = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nemo
    ];
  };
}
