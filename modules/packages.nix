{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages = {
      helix = pkgs.symlinkJoin {
        name = "helix";
        paths = [inputs.helix.packages.${pkgs.system}.default];
        nativeBuildInputs = [pkgs.makeWrapper];
        meta.mainProgram = "hx";
        postBuild = ''
          rm $out/bin/hx
          makeWrapper ${inputs.helix.packages.${pkgs.system}.default}/bin/hx $out/bin/hx \
            --prefix PATH : ${pkgs.lib.makeBinPath (with pkgs; [
            nixd
            nil
            lldb
            gdb
            bash-language-server
          ])}
        '';
      };

      ns = pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [fzf nix-search-tv];
        checkPhase = "";
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      };

      rdp = pkgs.symlinkJoin {
        name = "freerdp-smartcard";
        paths = [pkgs.freerdp];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          rm $out/bin/xfreerdp
          makeWrapper ${pkgs.freerdp}/bin/xfreerdp $out/bin/xfreerdp \
            --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [
            pkgs.opensc
            pkgs.p11-kit
          ]}
        '';
      };
    };
  };
}
