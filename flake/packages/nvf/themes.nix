{
  pkgs,
  occult-theme,
  ...
}: let
  inherit (occult-theme.themes) occult;
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
    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
      #style = "dark";
      #name = "base16";
      #base16-colors = occult;
    };
    startPlugins = with pkgs.vimPlugins; [
      everforest
      iceberg-vim
    ];

    extraPlugins = with pkgs.vimPlugins; {
      kanagawa = createTheme "kanagawa" kanagawa-nvim;
      ayu = createTheme "ayu" neovim-ayu;
      nightfox = createTheme "nightfox" nightfox-nvim;
      rose-pine = createTheme "rose-pine" rose-pine;
      catppuccin = createTheme "catppuccin" catppuccin-nvim;
      gruvbox = createTheme "gruvbox" gruvbox-nvim;
      starrynight = basicTheme starrynight;
    };
  };
}
