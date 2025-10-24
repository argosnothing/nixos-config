_: {
  vim.keymaps = [
    {
      key = "<C-t>";
      mode = "n";
      action = ":ToggleTerm dir=%:p:h<CR>";
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
}
