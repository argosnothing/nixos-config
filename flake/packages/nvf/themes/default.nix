{pkgs, ...}: let
  createTheme = name: package: {
    inherit package;
    setup = "require('${name}').setup {}";
  };
  # For simple Vim colorschemes
  basicTheme = package: {
    inherit package;
  };
in {
  vim = {
    startPlugins = with pkgs.vimPlugins; [
    ];

    extraPlugins = with pkgs.vimPlugins; {
      catppuccin = createTheme "catppuccin" catppuccin-nvim;
    };
  };
}
