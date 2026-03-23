vim.keymap.set("n", "<leader>aa", function()
    vim.cmd("packadd plenary.nvim")
    vim.cmd("packadd claude-code.nvim")
    require("claude-code").setup({
        window = {
            position = "float",
            float = {
                width = "80%",
                height = "80%",
                border = "rounded",
            },
        },
    })
    vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code" })
    vim.cmd("ClaudeCode")
end, { desc = "Toggle Claude Code" })
