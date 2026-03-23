local M = {}

function M.augroup(name)
	return vim.api.nvim_create_augroup("michael_" .. name, { clear = true })
end

return M
