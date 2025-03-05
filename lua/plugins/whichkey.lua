-- Ensure which-key is installed and loaded
local wk = require("which-key")

-- Define leader key mappings
wk.register({
	f = {
		name = "Find", -- Group name
		f = { "<cmd>Telescope find_files<CR>", "Find File" }, -- Example using Telescope
		b = { "<cmd>Telescope buffers<CR>", "Find Buffer" },
		h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
		w = { "<cmd>Telescope live_grep<CR>", "Find Text" },
	},
	E = { "<cmd>Neotree float toggle<CR>", "File Manager Float" },
	e = { "<cmd>Neotree left toggle<CR>", "File Manager Left" }, -- Example using NeoTree
	o = { "<cmd>Neotree float git_status<CR>", "Git Status" }, -- Example using NeoTree
	x = { "<cmd>Bdelete<CR>", "Close Buffer" }, -- Example using bdelete.nvim
	w = { "<cmd>w<CR>", "Save" },
	t = {
		name = "Terminal",
		f = { "<cmd>ToggleTerm direction=float<CR>", "Float Terminal" }, -- Example using ToggleTerm
		h = { "<cmd>ToggleTerm direction=horizontal<CR>", "Horizontal Terminal" },
	},
	h = { "<cmd>nohlsearch<CR>", "No Highlight" },
	g = {
		name = "Git",
		b = { "<cmd>Telescope git_branches<CR>", "Branches" }, -- Example using Telescope
		c = { "<cmd>Telescope git_commits<CR>", "Commits" },
		s = { "<cmd>Neotree float git_status<CR>", "Status" }, -- Example using NeoTree
	},
	c = {
		name = "Comment",
		l = { "<cmd>CommentToggle<CR>", "Comment Line" }, -- Example using Comment.nvim
	},
	l = {
		name = "LSP",
		d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic" },
		D = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Diagnostic" },
		f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" }, -- Example using Telescope
	},
}, { prefix = "<leader>" })

wk.setup({
	notify = false,
})
