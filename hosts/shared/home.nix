## Sadly Hjem is just too much work to configure properly.
## For the future i will be going forward using Home manager
## (skill issue)
{
  pkgs,
  self,
  settings,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.nixpkgs.hostPlatform) system;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule ["hj"] ["hjem" "users" settings.username])
    (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" settings.username])
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    extraSpecialArgs = {inherit self;};
    users.${settings.username} = {...}: {
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };
  hm = _: {
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
  hjem.users.${settings.username} = {
    enable = true;
    user = settings.username;
    directory = "/home/${settings.username}";
    packages = with pkgs; [
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
}
