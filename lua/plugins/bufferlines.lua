require("bufferline").setup {
    options = {
        buffer_clone_icon = " ",
        -- buffer_close_icon = ' ',
        close_icon = " ",
        show_buffer_close_icons = true,
        -- separator_style = "slant",
        mode = 'buffers',
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                separator = true,
                padding = 1
            }
        },
        diagnostics = "nvim_lsp",
        indicator = {
            icon = '  ', -- this should be omitted if indicator style is not 'icon'
            style = 'icon'
        },
        -- separator_style = "slope"
    }
}
