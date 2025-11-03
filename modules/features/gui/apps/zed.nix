{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {pkgs, ...}: {
    environment.systemPackages = [
      flake.packages.${pkgs.system}.zeditor
    ];
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
    hm = {
      stylix.targets.zed.enable = true;
    };
  };
}
