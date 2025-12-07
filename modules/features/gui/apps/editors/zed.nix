{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
    programs.nix-ld.enable = true;
    hj.packages = with flake.packages.${system}; [zeditor];
  };
}
