local function get_github_url()
    local remote = vim.fn.systemlist("git remote get-url origin")[1]
    if not remote or remote:match("^fatal") then
        return nil
    end

    remote = remote:gsub("git@github.com:", "https://github.com/")
    remote = remote:gsub("%.git$", "")

    local ref = vim.fn.systemlist("git rev-parse HEAD")[1]
    local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    local line = vim.fn.line(".")

    return remote .. "/blob/" .. ref .. "/" .. file .. "#L" .. line
end

vim.keymap.set("n", "<leader>gl", function()
    local url = get_github_url()
    if url then
        vim.fn.setreg("+", url)
        vim.notify("Copied: " .. url)
    else
        vim.notify("Not a git repo with a remote", vim.log.levels.ERROR)
    end
end, { desc = "Copy GitHub URL" })

vim.keymap.set("v", "<leader>gl", function()
    local remote = vim.fn.systemlist("git remote get-url origin")[1]
    if not remote or remote:match("^fatal") then
        vim.notify("Not a git repo with a remote", vim.log.levels.ERROR)
        return
    end

    remote = remote:gsub("git@github.com:", "https://github.com/")
    remote = remote:gsub("%.git$", "")

    local ref = vim.fn.systemlist("git rev-parse HEAD")[1]
    local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    local l1 = vim.fn.line("'<")
    local l2 = vim.fn.line("'>")

    local url = remote .. "/blob/" .. ref .. "/" .. file .. "#L" .. l1 .. "-L" .. l2
    vim.fn.setreg("+", url)
    vim.notify("Copied: " .. url)
end, { desc = "Copy GitHub URL (range)" })
