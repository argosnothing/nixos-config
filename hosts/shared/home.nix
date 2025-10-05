## Sadly Hjem is just too much work to configure properly.
## For the future i will be going forward using Home manager
## (skill issue)
{
  pkgs,
  settings,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.nixpkgs.hostPlatform) system;
  inherit (inputs.nixosModules) home-manager;
in {
  imports = [
    inputs.home-manager.nixosModules.default
    (lib.mkAliasOptionModule ["hj"] ["hjem" "users" settings.username])
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" settings.username])
  ];
  home-manager = {
    useGlobakPkgs = true;
    useUserPackages = true;
  };
  hjem.linker = inputs.hjem.packages.${system}.smfh;
  hjem.users.${settings.username} = {
    enable = true;
    user = settings.username;
    directory = "/home/${settings.username}";
    packages = with pkgs; [
      jq
      wev
      fzf
      ytfzf
      desktop-file-utils
      discord
      nix-direnv
      nix-direnv-flakes
      direnv
      spotify
      bolt-launcher
      mpv
      bash
      vesktop
      inputs.self.packages.${pkgs.system}.nvf
      inputs.self.packages.${pkgs.system}.ns
    ];
    files = {
      ".editorconfig".text = ''
        root = true

        [*]
        charset = utf-8
        end_of_line = lf
        indent_style = space
        insert_final_newline = true
        tab_width = 2
      '';
    };
  };
  my.persist.home = {
    directories = [
      "Downloads"
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
}
