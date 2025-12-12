{
  flake.modules.nixos.emacs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      emacs
      ripgrep
      coreutils
      fd
      clang
      emacsPackages.direnv
      rust-analyzer
      lldb
    ];
    my.persist = {
      home.directories = [
        ".config/emacs"
        ".config/doom"
        ".emacs.d"
      ];
    };
    services.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
    };
  };
}
