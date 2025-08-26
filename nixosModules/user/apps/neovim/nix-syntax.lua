-- Basic Nix file configuration
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.nix",
  callback = function()
    vim.bo.filetype = "nix"
    vim.bo.commentstring = "# %s"
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
  end,
})
