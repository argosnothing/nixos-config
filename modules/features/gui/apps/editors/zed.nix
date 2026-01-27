{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    my.persist.home.directories = [
      ".local/share/zed"
    ];
    quantum.directories = [
      ".config/zed"
    ];
    programs.nix-ld.enable = true;
    hj.packages = with flake.packages.${system}; [zeditor];
  };
}
