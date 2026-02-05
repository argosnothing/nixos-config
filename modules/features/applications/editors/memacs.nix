{
  flake.modules.nixos.memacs = {
    pkgs,
    lib,
    ...
  }: let
    emacsBase = pkgs.emacs;
    # emacsBase = pkgs.emacs-pgtk;
    emacsPkgs = pkgs.emacsPackagesFor emacsBase;

    runtimeTools = with pkgs; [
      fd
      ripgrep
      git
      rust-analyzer
      gnutls
      cacert
      nerd-fonts.caskaydia-cove
      nerd-fonts.symbols-only
      copilot-language-server
      graphviz
      nixd
      nil
      multimarkdown
    ];

    memacs = emacsPkgs.emacsWithPackages (epkgs:
      with epkgs; [
        use-package
        vterm
        kind-icon
        (treesit-grammars.with-grammars (g: [
          g.tree-sitter-rust
        ]))
      ]);

    emacsWrapped = pkgs.symlinkJoin {
      name = "memacs";
      paths = [memacs];
      buildInputs = [pkgs.makeWrapper];

      postBuild = ''
        wrapProgram $out/bin/emacs \
          --prefix PATH : ${lib.makeBinPath runtimeTools}
      '';
    };
  in {
    my.persist.home.directories = [
      ".emacs.d"
      "org"
    ];
    environment.systemPackages = [emacsWrapped];
  };
}
