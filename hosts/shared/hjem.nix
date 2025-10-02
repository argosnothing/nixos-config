{
  pkgs,
  settings,
  inputs,
  config,
  lib,
  ...
}: let
  inherit (config.nixpkgs.hostPlatform) system;
in {
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
      ".config/fastfetch/config.jsonc".source = ../../sources/.config/fastfetchconfig.jsonc;
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
