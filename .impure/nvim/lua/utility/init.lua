require("utility.autocmds")
require("utility.blink")
require("utility.conform")
require("utility.diagnostics")
require("utility.oil")
require("utility.terminal")
require("utility.vim")
require("utility.whichkey")
require("utility.avante")
require("utility.flash")
require("utility.cord")
require("utility.snacks")
require("utility.gitlink")

-- Lazy load gitsigns and to-do
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.cmd("packadd gitsigns.nvim")
        vim.cmd("packadd todo-comments.nvim")
        require("gitsigns").setup()
        require("todo-comments").setup()
    end,
})

-- Load DAP only for debuggable filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua", "c", "cpp", "rust" }, -- your targets
    once = true,
    callback = function()
        vim.cmd("packadd nvim-dap")
        vim.cmd("packadd nvim-dap-ui")
        require("utility.dap_config")
    end,
})
