{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.nvim = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    my.persist.home.directories = [
      ".local/state/mnw"
      ".local/share/mnw"
      ".cache/mnw"
    ];

    hj.packages = [flake.packages.${system}.nvim.devMode];
  };
}
