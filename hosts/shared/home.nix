{
  pkgs,
  settings,
  inputs,
  ...
}: {
  # Shared home-manager configuration for all hosts
  imports = [
    ../../nixosModules/user
  ];

  # Core packages shared across all hosts
  home.packages = with pkgs; [
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
    inputs.self.packages.${pkgs.system}.ns
  ];

  mpv.enable = true;
  programs.bash = {
    enable = true;
  };

  stylix.targets.vesktop.enable = false;
  programs.vesktop = {
    enable = true;
    settings = {
      staticTitle = true;
      hardwareAcceleration = false;
      discordBranch = "stable";
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

  home.file.".editorconfig".text = ''
    root = true

    [*]
    charset = utf-8
    end_of_line = lf
    indent_style = space
    insert_final_newline = true
    tab_width = 2
  '';
  git.enable = true;

  home.file.".config/fastfetch/config.jsonc".source = ../../sources/.config/fastfetchconfig.jsonc;

  home.shellAliases = {
    # https://github.com/Michael-C-Buckley/nixos/blob/1b09e5ae6c6431be61be8403c5774a47dbb2bbea/flake/user/files/.config/shells/aliases.sh#L42
    fetch = "fastfetch --logo ${settings.absoluteflakedir}/media/icons/purple-logo.png --logo-height 20 --logo-width 40";
  };
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;

  home.stateVersion = "25.05";

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [settings.monoFont];
      sansSerif = [settings.sansFont];
      serif = [settings.serifFont];
    };
  };
}
