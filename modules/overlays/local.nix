# https://github.com/Michael-C-Buckley/nixos/blob/94b398ea593a5a5f978f4de5a5d52531dc93aa4d/modules/overlays/local.nix
{config, ...}: {
  flake.overlays.default = _: prev: {
    inherit
      (config.flake.packages.${prev.system})
      kanso-nvim
      ns
      nvf
      nvf-copilot
      nvf-minimal
      thorn-nvim
      zeditor
      ;
  };
}
