-- -- Setup LSP
-- local lspconfig = require("lspconfig")
-- -- Lua
-- lspconfig.lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

-- -- Vim
-- lspconfig.vimls.setup({})

-- -- Markdown
-- lspconfig.marksman.setup({})

-- -- HTML (superhtml)
-- lspconfig.html.setup({})

-- -- CSS
-- lspconfig.cssls.setup({})

-- -- SCSS (optional, can use cssls or tailwindcss)
-- lspconfig.tailwindcss.setup({})

-- -- JavaScript/TypeScript
-- lspconfig.ts_ls.setup({})

-- -- Dockerfile
-- lspconfig.dockerls.setup({})

-- -- YAML
-- lspconfig.yamlls.setup({})

-- -- Python
-- lspconfig.pyright.setup({})

-- -- Angular
-- lspconfig.angularls.setup({})

-- -- JSON
-- lspconfig.jsonls.setup({
-- 	settings = {
-- 		json = {
-- 			schemas = require("schemastore").json.schemas(),
-- 			validate = { enable = true },
-- 		},
-- 	},
-- })

-- -- JSON5 (jsonls can handle JSON5)
-- lspconfig.jsonls.setup({
-- 	settings = {
-- 		json = {
-- 			schemas = require("schemastore").json.schemas(),
-- 			validate = { enable = true },
-- 		},
-- 	},
-- })

-- -- Nginx
-- lspconfig.nginx_language_server.setup({})

-- -- Global mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist)

-- -- Use LspAttach autocommand to only map the following keys
-- -- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
-- 	callback = function(ev)
-- 		-- Enable completion triggered by <c-x><c-o>
-- 		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

-- 		local opts = { buffer = ev.buf }
-- 		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- 		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- 		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
-- 		-- vim.keymap
-- 		--     .set('n', '<Leader>sa', vim.lsp.buf.add_workspace_folder, opts)
-- 		-- vim.keymap.set('n', '<Leader>sr', vim.lsp.buf.remove_workspace_folder,
-- 		--                opts)
-- 		-- vim.keymap.set('n', '<Leader>sl', function()
-- 		--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 		-- end, opts)
-- 		-- vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
-- 		vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, opts)
-- 		vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
-- 		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
-- 		vim.keymap.set("n", "<Leader>lf", function()
-- 			vim.lsp.buf.format({ async = true })
-- 		end, opts)
-- 	end,
-- })


-- lsp.lua
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Настройка базовых возможностей LSP
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Настройки для конкретных LSP серверов
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        telemetry = { enable = false }
      }
    }
  },
  eslint = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
    end
  },
  ts_ls = {  -- Используем typescript-language-server вместо tsserver
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end,
    root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
  },
  pyright = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
    end
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
        }
      }
    }
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true }
      }
    }
  }
}

-- Настройка каждого сервера
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend('force', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Общие keymaps для всех LSP
      local opts = { buffer = bufnr }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end
  }, config))
end

-- Настройка диагностики
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true
})

-- Форматирование при сохранении
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.lua', '*.py', '*.js', '*.ts', '*.json', '*.yaml', '*.html', '*.css' },
  callback = function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        -- Отключаем форматирование для ts_ls/pyright
        if client.name == 'ts_ls' or client.name == 'pyright' then
          return false
        end
        return true
      end
    })
  end
})

-- Keymaps для диагностики
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
