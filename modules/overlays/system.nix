{
  flake.nixpkgs.overlays = [
    (_: super: {
      inherit (super.stdenv.hostPlatform) system;
    })
  ];
}
