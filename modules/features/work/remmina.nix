{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.remmina = {pkgs, ...}: {
    my.persist.home.directories = [
      ".config/remmina"
      ".local/share/remmina"
    ];

    environment.systemPackages = [
      pkgs.remmina
      pkgs.pcsclite
      flake.packages.${pkgs.system}.rdp
    ];
  };
}
