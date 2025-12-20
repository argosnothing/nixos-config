{inputs, ...}: {
  perSystem = {
    system,
    pkgs,
    lib,
    self',
    ...
  }: let
    pkgs' = import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.nix-doom-emacs-unstraightened.overlays.default];
      config.allowUnfree = true;
    };

    emacsInputs = with pkgs'; [
      git
      ripgrep
      coreutils
      fd
      clang
      emacs
      emacsPackages.direnv
      rust-analyzer
      rustfmt
      lldb
      nixd
      nil
      alejandra
      cascadia-code
    ];

    emacsDoom = pkgs'.emacsWithDoom {
      doomDir = ./doom;
      doomLocalDir = "~/.local/share/nix-doom";
      extraPackages = epkgs: [epkgs.treesit-grammars.with-all-grammars];
    };

    wrapped = pkgs'.symlinkJoin {
      name = "emacs";
      paths = [emacsDoom];
      nativeBuildInputs = [pkgs'.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${pkgs'.lib.makeBinPath emacsInputs}

        if [ -x "$out/bin/emacsclient" ]; then
          wrapProgram $out/bin/emacsclient \
            --prefix PATH : ${pkgs'.lib.makeBinPath emacsInputs}
        fi
      '';
    };
  in {
    packages.emacs = wrapped;

    apps.emacs = {
      type = "app";
      program = "${wrapped}/bin/emacs";
    };
  };
}
