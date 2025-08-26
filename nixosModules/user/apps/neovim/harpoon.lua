local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add current file to harpoon
vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })

-- Toggle quick menu
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon menu" })

-- Navigate to harpooned files
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Go to harpoon file 1" })
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Go to harpoon file 2" })
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Go to harpoon file 3" })
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Go to harpoon file 4" })
