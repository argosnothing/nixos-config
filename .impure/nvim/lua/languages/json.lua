local lsp = require("languages.lsp")

vim.lsp.config("json", {
	capabilities = lsp.capabilities,
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
	single_file_support = true,
})

vim.lsp.enable("json")
