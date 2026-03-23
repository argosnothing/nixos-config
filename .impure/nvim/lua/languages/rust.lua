local lsp = require("languages.lsp")

vim.lsp.config("rust_analyzer", {
    cmd = { "false" },
    filetypes = {},
    root_markers = {},
})

local function start_rust_lsp()
    vim.lsp.start({
        name = "rust_analyzer",
        cmd = { "rust-analyzer" },
        root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),
        capabilities = lsp.capabilities,
    })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "DirenvLoaded",
    once = true,
    callback = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = start_rust_lsp,
        })
        if vim.bo.filetype == "rust" then
            start_rust_lsp()
        end
    end,
})
