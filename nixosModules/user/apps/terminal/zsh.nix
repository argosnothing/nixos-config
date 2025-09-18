{
  pkgs,
  settings,
  ...
}: {
  home.packages = [
    pkgs.zsh-powerlevel10k
    (pkgs.writeShellApplication
      {
        name = "show-tmpfs";
        runtimeInputs = [pkgs.fd];
        text = ''
          sudo fd --one-file-system --base-directory / --type f --hidden \
            --exclude "/etc/{ssh,passwd,shadow}" \
            --exclude "*.timer" \
            --exclude "/var/lib/NetworkManager" \
            --exec ls -lS | sort -rn -k5 | awk '{print $5, $9}'
        '';
      })
  ];
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./salivala.omp.json));
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins =
        [
          "git"
          "sudo"
          "z"
          "direnv"
          "history"
          "colored-man-pages"
          "extract"
          "command-not-found"
          "aliases"
          "docker"
          "kubectl"
          "virtualenv"
          "vi-mode"
        ]
        ++ {
          name = "fzf-tab";
          srs = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        };
    };
    shellAliases = import ./nixos-aliases.nix {inherit settings;};
    initContent = ''
      [[ -f ~/.profile ]] && source ~/.profile
    '';
    envExtra = ''
      export EDITOR=vim
      export VISUAL=vim
    '';
  };
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}
