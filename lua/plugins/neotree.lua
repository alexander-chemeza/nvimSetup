vim.diagnostic.config({
    signs = {
        error = { text = " " },
        warn = { text = " " },
        info = { text = " " },
        hint = { text = "󰌵" }
    }
})

require("neo-tree").setup({
    close_if_last_window = false,
})
