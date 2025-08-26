-- Toggle undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- Focus undo tree when toggling
vim.keymap.set("n", "<leader>U", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end, { desc = "Toggle and focus undo tree" })
