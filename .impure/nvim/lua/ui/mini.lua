require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.cursorword").setup()
require("mini.notify").setup()
require("mini.comment").setup()

local starter = require("mini.starter")
starter.setup({
    items = {
        { name = "Projects", action = "lua Snacks.picker.projects()", section = "Actions" },
        { name = "Recent Files", action = "lua Snacks.picker.recent()", section = "Actions" },
        { name = "Find Files", action = "lua Snacks.picker.files()", section = "Actions" },
        starter.sections.builtin_actions(),
    },
})
