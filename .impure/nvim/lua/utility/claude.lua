local function load_claude()
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
    vim.cmd("ClaudeCode")
end

vim.keymap.set("n", "<leader>aa", load_claude, { desc = "Toggle Claude Code" })
vim.keymap.set("n", "<C-,>", load_claude, { desc = "Toggle Claude Code" })
