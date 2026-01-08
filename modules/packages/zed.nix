# https://github.com/Michael-C-Buckley/nixos/blob/57b0063c530b68db614f234984554cf3acc485bf/packages/zed.nix#L20
# Just a simple way to put some tools in the Zed path
{
  perSystem = {pkgs, ...}: let
    zedInputs = with pkgs; [
      nil
      nixd
      pyright
      gopls
      clang-tools
      rust-analyzer

      # Formatters
      alejandra
      black
      gofumpt
      lldb
      gdb

      # Build tools
      python3
      go
    ];
  in {
    packages.zeditor = pkgs.symlinkJoin {
      name = "zeditor";
      paths = [pkgs.zed-editor];
      buildInputs = zedInputs;
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/zeditor \
        --prefix PATH : ${pkgs.lib.makeBinPath zedInputs} \

        #### Awful workaround I have to do because zeditor wont work with niri and nvidia
        --unset WAYLAND_DISPLAY \
        --set GDK_BACKEND x11 \

        if [ -d $out/share/applications ]; then
          rm -rf $out/share/applications
          mkdir -p $out/share/applications
          cp -r ${pkgs.zed-editor}/share/applications/*.desktop $out/share/applications/
          chmod -R +w $out/share/applications
          for desktop in $out/share/applications/*.desktop; do
            substituteInPlace $desktop \
              --replace "Exec=zeditor" "Exec=env WAYLAND_DISPLAY= GDK_BACKEND=x11 zeditor"
          done
        fi
      '';
    };
  };
}
