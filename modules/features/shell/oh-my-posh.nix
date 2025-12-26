{
  flake.modules.nixos.oh-my-posh = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      oh-my-posh
    ];
  };
}
