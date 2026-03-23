local opt = vim.opt

opt.scrollback = 10000

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.scrolloff = 8

opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true

opt.undofile = true
opt.swapfile = false

opt.updatetime = 250
opt.timeoutlen = 300

vim.g.direnv_silent_load = 1
