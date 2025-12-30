# My own, barebones emacs.
{
  flake.modules.nixos.memacs = {
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
      rust-analyzer
      gnutls
      cacert
    ];

    memacs = emacsPkgs.emacsWithPackages (epkgs:
      with epkgs; [
        use-package
        vterm
      ]);

    emacsWrapped = pkgs.symlinkJoin {
      name = "memacs";
      paths = [memacs];
      buildInputs = [pkgs.makeWrapper];

      postBuild = ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${lib.makeBinPath runtimeTools} \
          --run '
            BASE_HOME="$HOME"
            if [ "$(basename "$BASE_HOME")" = "memacs" ]; then
              BASE_HOME="$(dirname "$BASE_HOME")"
            fi

            MEMACS="$BASE_HOME/memacs"

            mkdir -p \
              "$MEMACS/.emacs.d" \
              "$MEMACS/.config" \
              "$MEMACS/.cache" \
              "$MEMACS/.local/share" \
              "$MEMACS/.local/state"

            export HOME="$MEMACS"
            export XDG_CONFIG_HOME="$MEMACS/.config"
            export XDG_CACHE_HOME="$MEMACS/.cache"
            export XDG_DATA_HOME="$MEMACS/.local/share"
            export XDG_STATE_HOME="$MEMACS/.local/state"
          '
      '';
    };
  in {
    my.persist.home.directories = [
      "memacs"
      "org"
    ];
    environment.systemPackages = [emacsWrapped];
  };
}
