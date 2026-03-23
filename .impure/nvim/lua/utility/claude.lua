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
    vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeToggle<cr>", { desc = "Toggle Claude Code" })
    vim.cmd("ClaudeCodeToggle")
end, { desc = "Toggle Claude Code" })
