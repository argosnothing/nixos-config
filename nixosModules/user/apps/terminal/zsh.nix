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
    useTheme = "lambda";
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
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
      ];
      #theme = "lambda";
      #custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
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
