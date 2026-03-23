-- Additional lazy loaded themes
-- Currently primarily called when using Snacks colorscheme picker

local themes = { "kanso", "kanagawa", "bamboo", "tokyonight" }

for _, theme in ipairs(themes) do
	vim.cmd("packadd " .. theme .. ".nvim")
	require(theme)
end
