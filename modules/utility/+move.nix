{inputs, ...}: {
  flake.lib.move = targetPath: let
    pathParts = builtins.split "/" targetPath;
    cleanParts = builtins.filter (p: builtins.isString p && p != "" && p != ".") pathParts;
    sourceName = builtins.elemAt cleanParts ((builtins.length cleanParts) - 1);
    sourcePath = inputs.self + "/${sourceName}";
    normalizedTarget =
      if builtins.substring ((builtins.stringLength targetPath) - 1) 1 targetPath == "/"
      then builtins.substring 0 ((builtins.stringLength targetPath) - 1) targetPath
      else targetPath;
  in {
    "${normalizedTarget}".source = sourcePath;
  };
}
