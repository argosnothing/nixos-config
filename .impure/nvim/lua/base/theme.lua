local themes = {
    "kanso",
    "kanagawa",
    "bamboo",
    "tokyonight",
    "dracula",
    "everforest",
    "nightfox",
    "nord",
    "onedark",
    "material",
    "sonokai",
    "cyberdream",
    "melange",
    "nightfly",
    "monokai-pro",
    "modus-themes",
    "github-nvim-theme",
    "fleet-theme",
    "oxocarbon",
    "catppuccin",
    "gruvbox",
}

local suffixes = { ".nvim", "-nvim", "" }
for _, theme in ipairs(themes) do
    for _, suffix in ipairs(suffixes) do
        local ok = pcall(vim.cmd, "packadd " .. theme .. suffix)
        if ok then
            break
        end
    end
    pcall(require, theme)
end

require("rose-pine").setup({ variant = "moon" })
vim.cmd.colorscheme("carbonfox")
