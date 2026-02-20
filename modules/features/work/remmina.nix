{config, ...}: let
  inherit (config) flake;
  in{
  flake.modules.nixos.remmina = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      remmina
      pcsclite
    ] ++ flake.packages.${pkgs.system}.rdp;
  };
}
