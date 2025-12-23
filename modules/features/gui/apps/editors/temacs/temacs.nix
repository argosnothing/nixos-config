{
  flake.modules.nixos.temacs =
    { pkgs, lib, ... }:

    let
      runtimeTools = with pkgs; [
        fd
        ripgrep
        git
      ];

      emacsWrapped = pkgs.symlinkJoin {
        name = "emacs-temacs";
        paths = [ pkgs.emacs ];
        buildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/emacs \
            --set HOME "$HOME/temacs" \
            --set XDG_CONFIG_HOME "$HOME/temacs/.config" \
            --set XDG_CACHE_HOME "$HOME/temacs/.cache" \
            --set XDG_DATA_HOME  "$HOME/temacs/.local/share" \
            --set XDG_STATE_HOME "$HOME/temacs/.local/state" \
            --prefix PATH : ${lib.makeBinPath runtimeTools}
        '';
      };
    in
    {
      environment.systemPackages = [ emacsWrapped ];
    };
}
