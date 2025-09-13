{
  pkgs,
  settings,
  inputs,
  ...
}: {
  # Shared home-manager configuration for all hosts
  imports = [
    ../nixosModules/user
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

  custom.persist.home = {
    directories = [
      "Downloads"
      "Pictures"
      "Projects"
      "Videos"
    ];
    cache.directories = [
      ".cache/nix-search-tv"
      ".cache/nvidia"
      ".cache/kitty"
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
