-- none-ls configuration for formatting and linting

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.alejandra,  -- Better Nix formatter
    null_ls.builtins.formatting.stylua,
  },
  
  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Additional keybinds for formatting
vim.keymap.set('n', '<leader>lf', function() 
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format buffer' })

-- Toggle diagnostics
vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })
