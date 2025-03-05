require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"superhtml",
		"css",
		"scss",
		"javascript",
		"typescript",
		"tsx",
		"dockerfile",
		"yaml",
		"python",
		"angular",
		"json",
		"json5",
		"nginx",
	},

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
