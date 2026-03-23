local M = {}

local terminal_buf = nil
local terminal_win = nil

-- Hide line numbers in the terminal
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

--- Close the terminal window without entering insert mode.
--- Safe to call even if the terminal is already closed.
M.close = function()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, true)
        terminal_win = nil
    end
end

local function toggle()
    -- Terminal is visible: hide it
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, true)
        terminal_win = nil
        return
    end

    -- Terminal is hidden: close DAP UI first (if loaded), then open terminal
    if package.loaded["dap"] then
        require("utility.dap_config").close_ui()
    end

    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
        vim.cmd("botright split")
        vim.cmd("resize 15")
        terminal_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
    else
        vim.cmd("botright split")
        vim.cmd("resize 15")
        vim.cmd("terminal")
        vim.opt_local.buflisted = false
        terminal_buf = vim.api.nvim_get_current_buf()
        terminal_win = vim.api.nvim_get_current_win()
    end

    vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<C-t>", toggle, { silent = true, noremap = true, desc = "Terminal: Toggle" })

-- Escape in terminal mode returns to normal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

return M
