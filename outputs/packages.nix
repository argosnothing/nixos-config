{inputs, ...}: {
  perSystem = {pkgs, ...}:
  {
    packages = {
      ns = pkgs.callPackage ../flake/packages/ns.nix {};
    };
  };
}
