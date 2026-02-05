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
      '';
    };
  };
}
