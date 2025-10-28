
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
