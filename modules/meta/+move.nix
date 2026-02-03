{inputs, ...}: {
  flake.lib.move = targetPath: let
    sourcePath = inputs.self + "/${targetPath}";
    normalizedTarget =
      if builtins.substring ((builtins.stringLength targetPath) - 1) 1 targetPath == "/"
      then builtins.substring 0 ((builtins.stringLength targetPath) - 1) targetPath
      else targetPath;
  in {
    "${normalizedTarget}".source = sourcePath;
  };
}
