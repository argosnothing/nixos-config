## Credit: Iynaix
{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.modules];

  flake.options.patches = lib.mkOption {
    type = lib.types.anything;
    default = [];
    description = "Patches to be applied onto nixpkgs";
  };
}
