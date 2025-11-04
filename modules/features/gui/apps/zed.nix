{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {pkgs, ...}: {
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
    hm = {
      home.packages = with flake.packages.${pkgs.system}; [zeditor];
      stylix.targets.zed.enable = false;
    };
  };
}
