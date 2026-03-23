require("cord").setup({
    text = {
        editing = function(opts)
            return "Editing " .. opts.filename .. " - Line " .. opts.cursor_line
        end,
    },
})
