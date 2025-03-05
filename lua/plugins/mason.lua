require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vimls",
		"marksman",
		"html",
		"cssls",
		"tailwindcss",
		"ts_ls",
		"dockerls",
		"yamlls",
		"pyright",
		"angularls",
		"jsonls",
		"jsonls",
		"nginx_language_server",
	},
})
