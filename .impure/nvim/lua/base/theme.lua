local themes = { "kanso", "kanagawa", "bamboo", "tokyonight" }

for _, theme in ipairs(themes) do
    vim.cmd("packadd " .. theme .. ".nvim")
    require(theme)
end

require("rose-pine").setup({ variant = "moon" })
vim.cmd.colorscheme("kanso")
