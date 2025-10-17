## Sadly Hjem is just too much work to configure properly.
## For the future i will be going forward using Home manager
## (skill issue)
{
  pkgs,
  self,
  inputs,
  username,
  lib,
  config,
  ...
}: let
  inherit (config.nixpkgs.hostPlatform) system;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hj"] ["hjem" "users" username])
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    extraSpecialArgs = {inherit self;};
    users.${username} = _: {
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };
  hm = _: {
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
    gtk = {
      enable = true;
      colorScheme = "dark";
    };
  };
  hj.systemd.enable = false;
  hjem.linker = inputs.hjem.packages.${system}.smfh;
  hjem.users.${username} = {
    enable = true;
    user = username;
    directory = "/home/${username}";
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
}
