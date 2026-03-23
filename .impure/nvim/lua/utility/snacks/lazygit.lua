vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gf", function()
    Snacks.lazygit.log_file()
end, { desc = "Lazygit file log" })
vim.keymap.set("n", "<C-g>", function()
    local dir = vim.fn.expand("%:p:h")
    if dir == "" or vim.fn.isdirectory(dir) == 0 then
        dir = vim.fn.getcwd()
    end
    Snacks.lazygit({ cwd = dir })
end, { desc = "Lazygit (file dir)" })
