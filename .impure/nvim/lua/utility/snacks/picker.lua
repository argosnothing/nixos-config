require("snacks")
local picker = Snacks.picker
local function bind_picker(bind, func, desc, import)
    if import ~= nil then
        require(import)
    end
    vim.keymap.set("n", bind, function()
        func()
    end, { desc = desc })
end

-- Files
bind_picker("<leader><space>", picker.smart, "Smart find files")
bind_picker("<leader>f", picker.files, "Find files")
bind_picker("<leader>r", picker.recent, "Recent files")
bind_picker("<leader>e", picker.explorer, "File Explorer")
bind_picker("<leader>q", picker, "Browse Pickers")
bind_picker("<leader>pp", picker.projects, "Projects")
bind_picker("<leader>pf", picker.files, "Project Files")
bind_picker("<leader>pg", picker.grep, "Project Grep")
bind_picker("<leader>pb", picker.buffers, "Project Buffers")
bind_picker("<leader>pr", picker.recent, "Project Recent")

-- Search
bind_picker("<leader>/", picker.grep, "Grep")
bind_picker("<leader>b", picker.buffers, "Buffers")
bind_picker("<leader>cs", picker.colorschemes, "Color Schemes", "base.theme")

-- LSP (replaces telescope for these)
bind_picker("gr", picker.lsp_references, "LSP References")
bind_picker("gd", picker.lsp_definitions, "LSP Definitions")
