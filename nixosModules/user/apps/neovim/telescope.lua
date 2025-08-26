local builtin = require('telescope.builtin')

-- File finding
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find git files' })

-- Text searching
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Search text' })

-- Live grep (requires ripgrep)
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Live grep' })

-- Buffer searching
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Find buffers' })
