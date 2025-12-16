{inputs, ...}: {
  flake.modules.nixos.emacs = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.nix-doom-emacs-unstraightened.overlays.default];
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
        nixd
      ]
      ++ [
        (pkgs.emacsWithDoom {
          doomDir = ./doom;
          doomLocalDir = "~/.local/share/nix-doom";
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
