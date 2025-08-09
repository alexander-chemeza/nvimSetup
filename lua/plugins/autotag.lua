require('nvim-ts-autotag').setup()

-- Modern LSP diagnostics config
vim.diagnostic.config({
    underline = true,
    virtual_text = {
        spacing = 5,
        severity_limit = "Warning", -- Hide virtual text for "Info" diagnostics
    },
    signs = true,                   -- Show signs in gutter
    update_in_insert = false,       -- Better performance (default)
    severity_sort = true,           -- Prioritize errors
})

-- Optional: Customize diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
