local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.eslint_d.with({
			filetypes = {
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
			},
		}),
		-- null_ls.builtins.formatting.lua_format,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
			},
		}),
		-- null_ls.builtins.formatting.black, -- Python
		null_ls.builtins.formatting.autopep8, -- Python
		-- null_ls.builtins.formatting.isort, -- Python
		null_ls.builtins.formatting.yamlfmt, -- YAML
		null_ls.builtins.formatting.fixjson, -- JSON
		null_ls.builtins.formatting.markdownlint, -- Markdown
		null_ls.builtins.formatting.nginx_beautifier, -- Nginx

		-- Diagnostics (Linters)
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.ltrs,
		-- null_ls.builtins.diagnostics.flake8, -- Python
		null_ls.builtins.diagnostics.pylint, -- Python
		null_ls.builtins.diagnostics.hadolint, -- Dockerfile
		null_ls.builtins.diagnostics.yamllint, -- YAML
		null_ls.builtins.diagnostics.jsonlint, -- JSON
		null_ls.builtins.diagnostics.markdownlint, -- Markdown
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
