local M = {}

local dap = require("dap")
local dapui = require("dapui")

local dapui_open = false

dap.adapters.lldb = {
    type = "executable",
    command = "lldb-dap",
    name = "lldb",
}

dap.configurations.rust = {
    {
        name = "Debug",
        type = "lldb",
        request = "launch",
        program = function()
            vim.fn.system("cargo build 2>&1")
            local cwd = vim.fn.getcwd()
            local bins = vim.fn.glob(cwd .. "/target/debug/*", false, true)
            bins = vim.tbl_filter(function(f)
                return vim.fn.isdirectory(f) == 0 and vim.fn.getfperm(f):match("^r.x") and not f:match("%.")
            end, bins)
            if #bins == 1 then
                return bins[1]
            end
            if #bins > 1 then
                local choice
                vim.ui.select(bins, { prompt = "Select binary:" }, function(selected)
                    choice = selected
                end)
                return choice
            end
            return vim.fn.input("Binary: ", cwd .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
    },
}

-- ── DAP-UI setup + auto open/close ──────────────────────────────────────────

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.4 },
                { id = "breakpoints", size = 0.15 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.2 },
            },
            size = 50,
            position = "left",
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    dapui_open = true
end
-- On session end, close only the sidebar (layout 1) but keep the bottom
-- console/repl panel (layout 2) open so print() output persists.
-- Use <leader>du to dismiss it when you're done.
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dapui_open = false
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dapui_open = false
end

-- ── Breakpoint signs ─────────────────────────────────────────────────────────

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

-- Highlight groups (subtle defaults; your colorscheme may override these)
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#5c6370" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e3b28" })

-- ── Public API ───────────────────────────────────────────────────────────────

--- Close DAP UI if it is currently open.
--- Safe to call even when DAP UI is already closed.
M.close_ui = function()
    if dapui_open then
        dapui.close()
        dapui_open = false
    end
end

-- ── Keymaps ──────────────────────────────────────────────────────────────────

local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = "DAP: " .. desc })
end

map("n", "<leader>dc", dap.continue, "Continue / Start")
map("n", "<leader>dn", dap.step_over, "Next (Step Over)")
map("n", "<leader>di", dap.step_into, "Step Into")
map("n", "<leader>do", dap.step_out, "Step Out")
map("n", "<leader>dt", dap.terminate, "Terminate")
map("n", "<leader>dr", dap.restart, "Restart")
map("n", "<leader>dk", dap.run_to_cursor, "Run to Cursor")

map("n", "<leader>b", dap.toggle_breakpoint, "Toggle Breakpoint")
map("n", "<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional Breakpoint")
map("n", "<leader>bc", dap.clear_breakpoints, "Clear All Breakpoints")

map("n", "<leader>dh", dapui.eval, "Hover / Evaluate")
map("v", "<leader>dh", dapui.eval, "Evaluate Selection")
map("n", "<leader>de", function()
    dapui.eval(vim.fn.input("Expression: "))
end, "Evaluate Expression")
map({ "n", "t" }, "<leader>du", function()
    if dapui_open then
        M.close_ui()
    else
        require("utility.terminal").close()
        dapui.open()
        dapui_open = true
    end
end, "Toggle DAP UI")

return M
