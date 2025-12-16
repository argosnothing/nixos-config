{
  flake.modules.nixos.emacs = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [
        git
        ripgrep
        coreutils
        fd
        clang
        emacsPackages.direnv
        rust-analyzer
        lldb
      ]
      ++ [
        (pkgs.emacsWithDoom {
          doomDir = ./doom;
          doomLocalDir = "~/.local/share/nix-doom";
          extraPackages = with pkgs; [
            nixd
          ];
        })
      ];
    my.persist = {
      home.directories = [
        ".config/emacs"
        ".config/doom"
        ".local/share/nix-doom"
        ".emacs.d"
      ];
    };
    services.emacs = {
      enable = true;
      package = pkgs.emacs-gtk;
    };
  };
}
