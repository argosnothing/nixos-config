{
  flake.nixpkgs.overlays = [
    (final: _: {inherit (final.stdenv.hostPlatform) system;})
  ];
}
