vim.keymap.set("n", "<leader>aa", function()
    vim.cmd("packadd avante.nvim")
    require("avante").setup({
        provider = "claude",
        providers = {
            claude = {
                model = "claude-sonnet-4-20250514",
            },
        },
        input = {
            provider = "snacks",
        },
    })
    -- Replace stub so subsequent uses skip setup
    vim.keymap.set("n", "<leader>aa", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
    vim.cmd("AvanteToggle")
end, { desc = "Toggle Avante" })
