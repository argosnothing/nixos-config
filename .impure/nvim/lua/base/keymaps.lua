vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = true
    vim.keymap.set(mode, lhs, rhs, opts)
end

local allModes = { "n", "i", "v", "c", "t", "o", "x", "s" }

-- Basics
map("n", "<leader>qq", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map(allModes, "<F1>", "<Nop>") -- Disable F1
map(allModes, "<C-s>", ":write<cr>")

-- Window management (<leader>w as window prefix)
map("n", "<leader>w", "<C-w>", { desc = "Window" })

-- Buffer navigation
map(allModes, "<M-,>", ":bprevious<CR>")
map(allModes, "<M-.>", ":bnext<CR>")
map(allModes, "<M-w>", ":bdelete<CR>")

-- Window navigation
map(allModes, "<M-a>", "<C-w>w")
map(allModes, "<M-v>", "<C-w>v")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Commenting
map("n", "<C-/>", function()
    MiniComment.toggle_lines(vim.fn.line("."), vim.fn.line("."))
end, { desc = "Toggle comment" })

map("v", "<C-/>", function()
    MiniComment.toggle_lines(vim.fn.line("'<"), vim.fn.line("'>"))
end, { desc = "Toggle comment" })

-- Overridden Binds
-- These will be overwritten by something else, and exist just for information
-- like to inform that a certain plugin hasn't been loaded yet
vim.keymap.set("n", "<M-d>", function()
    vim.notify("DAP has not yet been loaded yet.")
end)
