local prefix = "● "
local prefix_width = vim.fn.strdisplaywidth(prefix)

-- Cache max line width per buffer, invalidated on buffer change
local buf_width_cache = {}

local function get_buf_max_width(bufnr)
	if buf_width_cache[bufnr] then
		return buf_width_cache[bufnr]
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local max_width = 0
	for _, l in ipairs(lines) do
		local w = vim.fn.strdisplaywidth(l)
		if w > max_width then
			max_width = w
		end
	end

	buf_width_cache[bufnr] = max_width

	-- Invalidate cache when buffer content changes
	vim.api.nvim_buf_attach(bufnr, false, {
		on_lines = function(_, b)
			buf_width_cache[b] = nil
		end,
		on_detach = function(_, b)
			buf_width_cache[b] = nil
		end,
	})

	return max_width
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "", -- Manually created since it needs to be after padding
		spacing = 0,
		format = function(diagnostic)
			local msg = diagnostic.message:match("^[^\n]+")
			local bufnr = diagnostic.bufnr or 0
			local lnum = diagnostic.lnum

			local lines = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)
			local line_width = vim.fn.strdisplaywidth(lines[1] or "")

			local max_line_width = get_buf_max_width(bufnr)
			local target = math.max(120, max_line_width + 2)

			-- prefix sits between our padding and the message, so subtract its width
			local pad = math.max(target - line_width - prefix_width, 1)

			return string.rep(" ", pad) .. prefix .. msg
		end,
	},

	underline = true,
	severity_sort = true,
	update_in_insert = false,

	float = {
		border = "rounded",
		source = "if_many",
	},
})

-- Show full diagnostic when cursor sits on the line
vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			scope = "cursor",
			border = "rounded",
			source = "if_many",
		})
	end,
})
