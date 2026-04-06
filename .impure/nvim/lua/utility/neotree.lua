vim.keymap.set("n", "<leader>e", function()
    vim.cmd("packadd plenary.nvim")
    vim.cmd("packadd nui.nvim")
    vim.cmd("packadd neo-tree.nvim")
    require("neo-tree").setup({
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            follow_current_file = { enabled = true },
        },
        window = {
            width = 30,
        },
        default_component_configs = {
            icon = {
                provider = function(icon, node)
                    local mini = require("mini.icons")
                    local text, hl
                    if node.type == "file" then
                        text, hl = mini.get("file", node.name)
                    elseif node.type == "directory" then
                        text, hl = mini.get("directory", node.name)
                    end
                    if text then icon.text = text end
                    if hl then icon.highlight = hl end
                end,
            },
        },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })
    vim.cmd("Neotree toggle")
end, { desc = "File Explorer" })
