{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.helix = pkgs.symlinkJoin {
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
  };
}
