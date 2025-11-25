{
  flake.modules.nvf.default = {
    vim.keymaps = [
      {
        key = "<leader>lf";
        mode = ["n"];
        lua = true;
        action = ''
          require('conform').format({
            lsp_format = "fallback"
          })
        '';
      }
    ];
    vim.binds = {
      whichKey = {
        enable = true;
      };
      cheatsheet.enable = true;
    };
  };
}
