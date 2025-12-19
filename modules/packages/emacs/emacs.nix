{ inputs, ... }:
{
  perSystem = { pkgs, ... }:
  let
    unstraightenedOverlay = inputs.nix-doom-emacs-unstraightened.overlays.default;
    pkgs' = pkgs.extend unstraightenedOverlay;
    emacsInputs = with pkgs'; [
      git ripgrep coreutils fd clang
      emacsPackages.direnv
      rust-analyzer lldb
      nixd nil
    ];

    emacsDoom = pkgs'.emacsWithDoom {
      doomDir = ./doom;
      doomLocalDir = "~/.local/share/nix-doom";
      extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
    };
  in
  {
    packages.emacs-doom-wrapped = pkgs'.symlinkJoin {
      name = "emacs-doom-wrapped";
      paths = [ emacsDoom ];
      nativeBuildInputs = [ pkgs'.makeWrapper ];

      postBuild = ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${pkgs'.lib.makeBinPath emacsInputs}

        if [ -x "$out/bin/emacsclient" ]; then
          wrapProgram $out/bin/emacsclient \
            --prefix PATH : ${pkgs'.lib.makeBinPath emacsInputs}
        fi
      '';
    };
  };
}
