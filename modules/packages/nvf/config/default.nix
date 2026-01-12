{
  flake.modules.nvf.default = {
    config.vim = {
      vimAlias = true;
      autopairs.nvim-autopairs.enable = true;
      dashboard.alpha = {
        enable = true;
        theme = "theta";
      };
      debugger.nvim-dap.ui.enable = true;
      comments.comment-nvim.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      projects.project-nvim.enable = true;
      telescope.enable = true;

      terminal = {
        toggleterm = {
          enable = true;
          setupOpts = {
            open_mapping = "[[<M-t>]]";
          };
        };
      };

      clipboard = {
        registers = "unnamedplus";
        providers = {
          wl-copy = {
            enable = true;
          };
        };
        enable = true;
      };

      autocomplete.nvim-cmp = {
        enable = true;
      };

      runner.run-nvim = {
        enable = true;
      };
    };
  };
}
