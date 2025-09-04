{pkgs, inputs, config, ...}: {
  imports = [inputs.schizofox.homeManagerModules.default];

  programs.schizofox = {
    enable = true;
  };
}