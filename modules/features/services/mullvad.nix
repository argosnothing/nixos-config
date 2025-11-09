{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.mullvad = {pkgs, ...}: {
    imports = [flake.modules.nixos.resolved];
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    my.persist.root.directories = [
      /etc/mullvad-vpn
    ];
  };
}
