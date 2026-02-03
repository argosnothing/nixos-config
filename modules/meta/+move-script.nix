{inputs, ...}: {
  flake.lib.move-script = {
    pkgs,
    targetPath,
  }: let
    sourceDir = inputs.self + "/" + targetPath;
    files = builtins.attrNames (builtins.readDir sourceDir);
    mkDrv = f: let
      m = builtins.match "^(.*)\\.[^\\.]+$" f;
      name = builtins.elemAt m 0;
      src = builtins.concatStringsSep "/" [
        (toString sourceDir)
        f
      ];
    in
      pkgs.writeShellScriptBin name src;
  in
    map mkDrv files;
}
