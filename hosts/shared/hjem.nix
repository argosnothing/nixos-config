{
  pkgs,
  settings,
  inputs,
  lib,
  ...
}: {
  hjem.users.${settings.username} = {
    enable = true;
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
  custom.persist.home = {
    directories = [
      "Downloads"
      "Pictures"
      "Projects"
      "Videos"

      ".var/app/com.spotify.Client"
      ".config/spotify"
    ];
    cache.directories = [
      ".cache/nix-search-tv"
      ".cache/nvidia"
      ".cache/kitty"
      ".cache/spotify"
    ];
  };
}
