{inputs, ...}: {
  flake.nixpkgs.overlays = [
    (_: super: {
      inherit (super.stdenv.hostPlatform) system;
    })
    inputs.nix-doom-emacs-unstraightened.overlays.defeault
  ];
}
