{
  flake.modules.nixos.temacs = {
    pkgs,
    lib,
    ...
  }: let
    emacsBase = pkgs.emacs-pgtk;
    emacsPkgs = pkgs.emacsPackagesFor emacsBase;

    runtimeTools = with pkgs; [
      fd
      ripgrep
      git
    ];

    temacs = emacsPkgs.emacsWithPackages (epkgs:
      with epkgs; [
        use-package
        vterm
      ]);

    emacsWrapped = pkgs.symlinkJoin {
      name = "emacs-temacs";
      paths = [temacs];
      buildInputs = [pkgs.makeWrapper];

      postBuild = ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${lib.makeBinPath runtimeTools} \
          --run '
            BASE_HOME="$HOME"
            if [ "$(basename "$BASE_HOME")" = "temacs" ]; then
              BASE_HOME="$(dirname "$BASE_HOME")"
            fi

            TEMACS="$BASE_HOME/temacs"

            mkdir -p \
              "$TEMACS/.emacs.d" \
              "$TEMACS/.config" \
              "$TEMACS/.cache" \
              "$TEMACS/.local/share" \
              "$TEMACS/.local/state"

            export HOME="$TEMACS"
            export XDG_CONFIG_HOME="$TEMACS/.config"
            export XDG_CACHE_HOME="$TEMACS/.cache"
            export XDG_DATA_HOME="$TEMACS/.local/share"
            export XDG_STATE_HOME="$TEMACS/.local/state"
          '
      '';
    };
  in {
    environment.systemPackages = [emacsWrapped];
  };
}
