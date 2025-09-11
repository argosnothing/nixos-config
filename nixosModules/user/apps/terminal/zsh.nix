{ pkgs, settings, ... }:
{
  home.packages = [ pkgs.zsh-powerlevel10k];
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
      theme = "powerlevel10k";
      custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    };
    shellAliases = import ./nixos-aliases.nix { inherit settings; };
    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      [[ -f ~/.profile ]] && source ~/.profile
    '';
    envExtra = ''
      export EDITOR=vim
      export VISUAL=vim
    '';
  };
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}
