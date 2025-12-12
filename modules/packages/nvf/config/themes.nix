{config, ...}: let
  inherit (config.flake) packages;
in {
  flake.modules.nvf.default = {pkgs, ...}: let
    inherit (pkgs) vimPlugins;
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    vim = {
      #theme = {
      #  enable = true;
      #  name = "vscode";
      #  style = "dark";
      #};
      extraPlugins = {
        vscode = {
          package = vimPlugins.vscode-nvim;
          setup = ''
            require('vscode').setup{}
            vim.cmd.colorscheme("vscode")
            --require('vscode').load()
          '';
        };
      };
      lazy.plugins = {
        "kanso-nvim".package = packages.${system}.kanso-nvim;
        "thorn-nvim".package = packages.${system}.thorn-nvim;
        "vscode.nvim".package = vimPlugins.vscode-nvim;
        everforest.package = vimPlugins.everforest;
        #"lackluster.nvim".package = vimPlugins.lackluster-nvim;
        #"kanagawa.nvim".package = vimPlugins.kanagawa-nvim;
        #"neovim-ayu".package = vimPlugins.neovim-ayu;
        #"catppuccin-nvim".package = vimPlugins.catppuccin-nvim;
        #"gruvbox.nvim".package = vimPlugins.gruvbox-nvim;
      };
    };
  };
}
