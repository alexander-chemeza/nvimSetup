-- local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- null_ls.setup({
-- 	sources = {
-- 		-- Formatters
-- 		null_ls.builtins.formatting.eslint_d.with({
-- 			filetypes = {
-- 				"typescript",
-- 				"javascript",
-- 				"typescriptreact",
-- 				"javascriptreact",
-- 			},
-- 		}),
-- 		-- null_ls.builtins.formatting.lua_format,
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.formatting.rustfmt,
-- 		null_ls.builtins.formatting.prettierd.with({
-- 			filetypes = {
-- 				"css",
-- 				"scss",
-- 				"less",
-- 				"html",
-- 				"json",
-- 				"jsonc",
-- 				"yaml",
-- 				"markdown",
-- 				"markdown.mdx",
-- 				"graphql",
-- 				"handlebars",
-- 			},
-- 		}),
-- 		-- null_ls.builtins.formatting.black, -- Python
-- 		null_ls.builtins.formatting.autopep8, -- Python
-- 		-- null_ls.builtins.formatting.isort, -- Python
-- 		null_ls.builtins.formatting.yamlfmt, -- YAML
-- 		null_ls.builtins.formatting.fixjson, -- JSON
-- 		null_ls.builtins.formatting.markdownlint, -- Markdown
-- 		null_ls.builtins.formatting.nginx_beautifier, -- Nginx

-- 		-- Diagnostics (Linters)
-- 		null_ls.builtins.diagnostics.eslint_d,
-- 		null_ls.builtins.diagnostics.ltrs,
-- 		-- null_ls.builtins.diagnostics.flake8, -- Python
-- 		null_ls.builtins.diagnostics.pylint, -- Python
-- 		null_ls.builtins.diagnostics.hadolint, -- Dockerfile
-- 		null_ls.builtins.diagnostics.yamllint, -- YAML
-- 		null_ls.builtins.diagnostics.jsonlint, -- JSON
-- 		null_ls.builtins.diagnostics.markdownlint, -- Markdown
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				buffer = bufnr,
-- 				callback = function()
-- 					vim.lsp.buf.format({
-- 						bufnr = bufnr,
-- 						filter = function(client)
-- 							return client.name == "null-ls"
-- 						end,
-- 					})
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })


-- local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- -- Initialize required client capabilities
-- local on_init = function(client)
--   client._request_name_to_capability = client._request_name_to_capability or {}
--   client._capabilities = client._capabilities or vim.lsp.protocol.make_client_capabilities()
-- end

-- null_ls.setup({
--   on_init = on_init,
--   sources = {
--     -- Formatters (only include installed tools)
--     null_ls.builtins.formatting.stylua,
--     null_ls.builtins.formatting.prettierd.with({
--       filetypes = {
--         "css", "scss", "less", "html", 
--         "json", "jsonc", "yaml", "markdown",
--         "markdown.mdx", "graphql", "handlebars"
--       },
--       disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
--     }),
--     null_ls.builtins.formatting.eslint_d.with({
--       filetypes = {
--         "javascript", "javascriptreact",
--         "typescript", "typescriptreact"
--       },
--       prefer_local = "node_modules/.bin"
--     }),
--     null_ls.builtins.formatting.autopep8,
--     null_ls.builtins.formatting.yamlfmt,
--     null_ls.builtins.formatting.fixjson,
--     null_ls.builtins.formatting.markdownlint,

--     -- Diagnostics (only include installed tools)
--     null_ls.builtins.diagnostics.eslint_d.with({
--       prefer_local = "node_modules/.bin"
--     }),
--     null_ls.builtins.diagnostics.pylint,
--     null_ls.builtins.diagnostics.yamllint,
--     null_ls.builtins.diagnostics.markdownlint,
    
--     -- Removed problematic/unavailable tools:
--     -- null_ls.builtins.formatting.rustfmt, (install via rustup)
--     -- null_ls.builtins.formatting.nginx_beautifier,
--     -- null_ls.builtins.diagnostics.ltrs,
--     -- null_ls.builtins.diagnostics.hadolint,
--     -- null_ls.builtins.diagnostics.jsonlint,
--   },
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({
--             bufnr = bufnr,
--             filter = function(client)
--               return client.name == "null-ls"
--             end,
--             async = false -- Ensure formatting completes before write
--           })
--         end,
--       })
--     end
--   end,
-- })

-- -- Ensure Mason binaries are in PATH
-- vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"


local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Enhanced client initialization
local on_init = function(client, bufnr)
  -- Initialize required capability fields
  client._request_name_to_capability = client._request_name_to_capability or {}
  client._capabilities = client._capabilities or vim.lsp.protocol.make_client_capabilities()
  
  -- Python-specific workaround
  if vim.bo[bufnr].filetype == "python" then
    client._capabilities.textDocument = client._capabilities.textDocument or {}
    client._capabilities.textDocument.formatting = true
    client._capabilities.textDocument.rangeFormatting = true
  end
end

null_ls.setup({
  on_init = on_init,
  sources = {
    -- Formatters
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "css", "scss", "less", "html", 
        "json", "jsonc", "yaml", "markdown",
        "markdown.mdx", "graphql", "handlebars"
      }
    }),
    null_ls.builtins.formatting.eslint_d.with({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact"
      }
    }),
    null_ls.builtins.formatting.autopep8.with({
      -- Extra Python-specific settings
      extra_args = { "--max-line-length=88" },
      runtime_condition = function(params)
        return params.bufname and not params.bufname:match("%f[%w]test%.py%f[%W]")
      end
    }),
    
    -- Diagnostics
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.pylint.with({
      -- Prevent pylint from running on test files
      runtime_condition = function(params)
        return params.bufname and not params.bufname:match("%f[%w]test%.py%f[%W]")
      end
    }),
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.markdownlint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- Add filetype-specific delay for Python
          local timeout = vim.bo[bufnr].filetype == "python" and 2000 or 1000
          
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(c) return c.name == "null-ls" end,
            timeout_ms = timeout,
            async = false
          })
        end
      })
    end
  end,
})

-- Ensure Python tools are properly configured
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.b.null_ls_formatting_disabled = false
  end
})