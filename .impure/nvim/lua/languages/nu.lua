local lsp = require("languages.lsp")

vim.lsp.config("nu", {
	capabilities = lsp.capabilities,
	cmd = { "nu", "--lsp" },
	filetypes = { "nu" },
	root_markers = { ".git" },
	single_file_support = true,
})

vim.lsp.enable("nu")
