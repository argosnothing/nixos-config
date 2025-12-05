{
  flake.modules.nixos.toys = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      pipes
      cbonsai
    ];
  };
}
