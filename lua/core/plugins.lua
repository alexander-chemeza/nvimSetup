-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Plugin to add pairs
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true,
        },
        -- Plugin to see files and folders
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
            },
        },
        -- Plugin to user terminal
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true,
        },
        -- Plugin for syntax parsing
        { "nvim-treesitter/nvim-treesitter" },
        -- Plugin for quick search
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        -- My theme
        { 'marko-cerovac/material.nvim' },
        { "zaldih/themery.nvim",            lazy = false },
        -- Plugin to add symbols for warning, errors end etc.
        { "windwp/nvim-ts-autotag" },
        -- Plugin to add a row with opened files
        {
            "akinsho/bufferline.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" }
        },
        -- Plugin to toggle comments
        { "terrortylor/nvim-comment" },
        -- Plugin to add startpage
        {
            "glepnir/dashboard-nvim",
            event = "VimEnter",
            dependencies = { { "nvim-tree/nvim-web-devicons" } },
        },
        -- Plugin for deep buffer integration for git
        { "lewis6991/gitsigns.nvim" },
        -- Plugin for statuslines
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
                "linrongbin16/lsp-progress.nvim",
            },
        },
        -- Plugin for outline buffer
        { "Djancyp/outline" },
        { "echasnovski/mini.nvim" },
        -- Plugin to show menu on leader
        { "folke/which-key.nvim" },
        -- For YAML/JSON
        { "b0o/SchemaStore.nvim" },
        -- Manager to install lsp, linter, formatters
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
        },
        -- Bridge between mason and LSP
        { "williamboman/mason-lspconfig.nvim" },
        -- LSP configuration
        { "neovim/nvim-lspconfig" },
        -- Autocomplete for lsp
        { "hrsh7th/cmp-nvim-lsp" },
        -- Autocomplete for buffer
        { "hrsh7th/cmp-buffer" },
        -- Autocomplete for paths
        { "hrsh7th/cmp-path" },
        -- Command line autocomplete
        { "hrsh7th/cmp-cmdline" },
        -- Autocomplete engine
        { "hrsh7th/nvim-cmp" },
        --- Snippet engine
        { "L3MON4D3/LuaSnip",                 build = "make install_jsregexp" },
        { "saadparwaiz1/cmp_luasnip" },
        -- Formatters
        {
            'stevearc/conform.nvim',
            opts = {},
        },
        -- Show git diff
        { 'sindrets/diffview.nvim' },
        -- Folding plugin
        { 'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' } },
        {
            "lukas-reineke/indent-blankline.nvim",
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "material-darker" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
