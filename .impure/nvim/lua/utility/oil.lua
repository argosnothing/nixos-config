vim.keymap.set("n", "<C-o>", function()
    vim.cmd("packadd oil.nvim")
    local oil = require("oil")
    oil.setup({
        view_options = { show_hidden = true },
        keymaps = {
            ["q"] = "actions.close",
            ["<C-o>"] = "actions.parent",
        },
    })
    -- Replace stub with direct call so subsequent uses skip setup
    vim.keymap.set("n", "<C-o>", oil.open, { desc = "Open parent directory" })
    oil.open()
end, { desc = "Open parent directory" })
