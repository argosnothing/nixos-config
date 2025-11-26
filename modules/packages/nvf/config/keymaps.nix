{
  flake.modules.nvf.default = {
    vim.keymaps = [
      {
        mode = "n";
        key = "<leader>lf";
        action = ":lua vim.lsp.buf.format()<CR>";
        silent = true;
      }
      {
        key = "<C-t>";
        mode = "n";
        action = ":ToggleTerm dir=%:p:h direction=float <CR>";
      }
      {
        key = "<Esc> <Esc>";
        mode = "t";
        action = "exit <CR>";
      }
      {
        key = "<C-o>";
        mode = "n";
        action = ":Oil <CR>";
      }
      {
        key = "<C-p>";
        mode = "n";
        silent = true;
        action = ":harpoon:list:prev<CR>";
      }
    ];
  };
}
