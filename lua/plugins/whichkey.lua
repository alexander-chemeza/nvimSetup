-- Ensure which-key is installed and loaded
local wk = require("which-key")


wk.add({
    -- Buffer
    { "<leader>b",  group = "Buffer" },
    { "<leader>bx", "<cmd>BufferLinePickClose<CR>",                   desc = "Buffer Pick Close" },
    { "<leader>bX", "<cmd>BufferLineCloseRight<CR>",                  desc = "Buffer Close Right" },
    { "<leader>bs", "<cmd>BufferLineSortByTabs<CR>",                  desc = "Buffer Sort By Tabs" },
    -- Find files
    { "<leader>f",  group = "Files" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>",                  desc = "Find File" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>",                     desc = "Find Buffer" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",                   desc = "Find Help" },
    { "<leader>ft", "<cmd>Telescope live_grep<CR>",                   desc = "Find Text" },
    { "<leader>fc", "<cmd>bd<CR>",                                    desc = "Close Buffer" },
    { "<leader>fw", "<cmd>w<CR>",                                     desc = "Save" },
    -- Git
    { "<leader>g",  group = "Git" },
    { "<leader>gb", "<cmd>Telescope git_branches<CR>",                desc = "Git Branches" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>",                 desc = "Git Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>",                  desc = "Git Status" },
    -- Neotree
    { "<leader>n",  group = "Neotree" },
    { "<leader>ns", "<cmd>Neotree left toggle<CR>",                   desc = "Neotree Left Toggle" },
    { "<leader>nf", "<cmd>Neotree float toggle<CR>",                  desc = "Neotree Float Toggle" },
    { "<leader>no", "<cmd>Neotree float git_status<CR>",              desc = "Neotree Float Git Status" },
    -- Terminal
    { "<leader>t",  group = "Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",            desc = "Terminal Float Toggle" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",       desc = "Terminal Horizontal Toggle" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<CR>", desc = "Terminal Vertical Toggle" },
    -- LSP
    { "<leader>l",  group = "LSP" },
    { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>",       desc = "Diagnostic" },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.hover()<CR>",               desc = "Hover Diagnostic" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>",              desc = "Format" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>",              desc = "Rename" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",         desc = "Code Action" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",        desc = "Document Symbols" },
    -- Comments
    { "<leader>/",  "<cmd>CommentToggle<CR>",                         desc = "Document Symbols",          mode = "n" },
    { "<leader>/",  ":'<,'>CommentToggle<CR>",                        desc = "Document Symbols",          mode = "v" },
    -- Highlights
    { "<leader>h",  "<cmd>nohlsearch<CR>",                            desc = "No Highlights" },
    -- Tabs
    { "<Tab>",      "<cmd>BufferLineCycleNext<CR>",                   desc = "Next Tab" },
    { "<s-Tab>",    "<cmd>BufferLineCyclePrev<CR>",                   desc = "Prev Tab" },
    -- Splits
    { "|",          "<cmd>vsplit<CR>",                                desc = "Vertical Split" },
    { "\\",         "<cmd>split<CR>",                                 desc = "Horizontal Split" },
    -- Navigation
    { "<c-k>",      "<cmd>wincmd k<CR>",                              desc = "Go to Above Window" },
    { "<c-j>",      "<cmd>wincmd j<CR>",                              desc = "Go to Bottom Window" },
    { "<c-h>",      "<cmd>wincmd h<CR>",                              desc = "Go to Left Window" },
    { "<c-l>",      "<cmd>wincmd l<CR>",                              desc = "Go to Right Window" },
    { "|",          "<cmd>vsplit<CR>",                                desc = "Vertical Split" },
    { "|",          "<cmd>vsplit<CR>",                                desc = "Vertical Split" },
    -- Other
    { "jj",         "<Esc>",                                          desc = "Exit mode",                 mode = "i" },
    { "<leader>qa", "<cmd>quitall<CR>",                               desc = "Quit Neovim" }
})


wk.setup({
    notify = false,
})
