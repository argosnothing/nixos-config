{ inputs, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages.${builtins.currentSystem};
in {
  flake.lib.move-script = targetPath:
    let
      sourceDir = inputs.self + "/" + targetPath;
      normalizedTarget =
        if builtins.substring ((builtins.stringLength targetPath) - 1) 1 targetPath == "/"
        then builtins.substring 0 ((builtins.stringLength targetPath) - 1) targetPath
        else targetPath;
      files = builtins.readDir sourceDir;
      entries = builtins.map (f:
        let
          m = builtins.match "^(.*)\\.[^\\.]+$" f;
          name = if m == null then f else m[1];
        in
        { name = name; value = pkgs.stdenv.mkDerivation {
            pname = "script-${name}";
            version = "1";
            src = sourceDir + "/" + f;
            buildPhase = ''
              mkdir -p $out/bin
              cp $src $out/bin/${name}
              chmod 0755 $out/bin/${name}
            '';
            meta = { description = "script ${name} from ${targetPath}"; };
        }; }
      ) files;
    in { "${normalizedTarget}" = builtins.listToAttrs entries; };
}
