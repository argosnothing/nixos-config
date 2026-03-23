local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Attach keymaps only when LSP connects
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", function()
            Snacks.picker.lsp_definitions()
        end, "Go to Definition")
        map("gD", function()
            Snacks.picker.lsp_declarations()
        end, "Go to Declaration")
        map("gr", function()
            Snacks.picker.lsp_references()
        end, "References")
        map("K", vim.lsp.buf.hover, "Hover Docs")
        map("<leader>k", vim.lsp.buf.hover, "Hover Docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>af", vim.lsp.buf.format, "Format")
    end,
})

return M
