-- Git status
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })

-- Git blame
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })

-- Git diff
vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
