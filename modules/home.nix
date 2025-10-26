## Configure Anything that has to do with home stuff here.
{
  lib,
  inputs,
  config,
  ...
}: let
  inherit (config) flake;
in {
  flake.modules.nixos.home = {pkgs, ...}: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.hjem.nixosModules.default
      (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" flake.settings.username])
      (lib.mkAliasOptionModule ["hj"] ["hjem" "users" flake.settings.username])
    ];
    config = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        overwriteBackup = true;
        users.${flake.settings.username} = _: {
          home.stateVersion = "25.05";
          programs.home-manager.enable = true;
        };
      };
      my.persist.home.directories = lib.mkAfter [
        ".local/share/direnv"
        ".config/yazi"
        ".config/sops"
        ".ssh"
        "nixos-config"
      ];

      hm = {
        my.persist.home = {
          directories = [
            "Downloads"
            "Games"
            "Pictures"
            "Projects"
            "Videos"
            ".local/share/nvf"
            ".var/app/com.spotify.Client"
            ".config/spotify"
          ];
          cache.directories = [
            ".cache/nvf"
            ".cache/nix-search-tv"
            ".cache/nvidia"
            ".cache/kitty"
            ".cache/spotify"
          ];
        };
        home.packages = with pkgs; [
          jq
          wev
          fzf
          ytfzf
          desktop-file-utils
          nix-direnv
          nix-direnv-flakes
          direnv
          bolt-launcher
          mpv
          bash
          vulkan-tools
          inputs.self.packages.${pkgs.system}.nvf
          inputs.self.packages.${pkgs.system}.ns
        ];
      };
    };
  };
}
