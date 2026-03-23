local lsp = require("languages.lsp")
vim.cmd("packadd nvim-dap")
local dap = require("dap")

vim.cmd("packadd nvim-dap-python")
local dap_python = require("dap-python")

-- ── LSP ──────────────────────────────────────────────────────────────────────

vim.lsp.config("basedpyright", {
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	capabilities = lsp.capabilities,
	settings = {
		basedpyright = {
			typeCheckingMode = "standard",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.config("ruff", {
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", ".git" },
	capabilities = lsp.capabilities,
	on_attach = function(client)
		-- Disable hover so basedpyright handles it instead
		client.server_capabilities.hoverProvider = false
	end,
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")

-- ── DAP adapter (via nvim-dap-python) ────────────────────────────────────────
-- Handles adapter registration AND virtualenv-aware pythonPath automatically
dap_python.setup(vim.g.python3_host_prog)
dap_python.test_runner = "pytest"

-- ── Additional launch configurations ─────────────────────────────────────────
-- nvim-dap-python already registers a "Launch file" and test configs;
-- we append extra useful ones.

dap.configurations.python = dap.configurations.python or {}

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Launch file with arguments",
	program = "${file}",
	args = function()
		local input = vim.fn.input("Arguments: ")
		return vim.split(input, " ", { trimempty = true })
	end,
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Launch module (-m)",
	module = function()
		return vim.fn.input("Module name: ")
	end,
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "attach",
	name = "Attach to running process",
	connect = {
		host = "127.0.0.1",
		port = function()
			return tonumber(vim.fn.input("Port [5678]: ")) or 5678
		end,
	},
})

-- nvim-dap-python extras (test runners)
local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = "DAP: " .. desc })
end

map("n", "<leader>dm", dap_python.test_method, "Debug Test Method")
map("n", "<leader>dc", dap_python.test_class, "Debug Test Class")
map("v", "<leader>ds", dap_python.debug_selection, "Debug Selection")
