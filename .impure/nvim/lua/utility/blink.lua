vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.cmd("packadd blink.cmp")
        vim.cmd("packadd LuaSnip")
        vim.cmd("packadd friendly-snippets")
        require("blink.cmp").setup({
            snippets = { preset = "luasnip" },
            completion = {
                list = { selection = { preselect = true, auto_insert = true } },
                menu = { auto_show = true },
                accept = { auto_brackets = { enabled = true } },
            },
            keymap = {
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<C-space>"] = { "show" },
            },
        })
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
})
