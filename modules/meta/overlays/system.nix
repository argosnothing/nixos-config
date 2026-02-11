{inputs, ...}: {
  flake.nixpkgs.overlays = [
    inputs.helix.overlays.default
    (_: super: {
      inherit (super.stdenv.hostPlatform) system;
    })
  ];
}
