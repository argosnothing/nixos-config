vim.cmd("packadd nvim-lspconfig")
require("languages.lsp")
require("languages.tree-sitter")

-- Load language configs only when that filetype is opened
local function language(name, pattern)
    pattern = pattern or name
    vim.api.nvim_create_autocmd("FileType", {
        pattern = pattern,
        once = true,
        callback = function()
            require("languages." .. name)
        end,
    })
end

language("lua")
language("nix")
language("python")
language("nu")
language("json")
language("rust")
