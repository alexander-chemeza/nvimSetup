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
    ts_ls = {
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
        end,
        root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
    },
    basedpyright = { -- Заменяем pyright на basedpyright
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.codeActionProvider = {
                resolveProvider = true,
                codeActionKinds = {
                    "quickfix",
                    "refactor",
                    "source.organizeImports",
                }
            }
        end,
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                }
            }
        }
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


-- Форматирование при сохранении
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.lua', '*.py', '*.js', '*.ts', '*.json', '*.yaml', '*.html', '*.css' },
    callback = function()
        vim.lsp.buf.format({
            async = false,
            -- filter = function(client)
            -- Отключаем форматирование для ts_ls/basedpyright
            -- if client.name == 'ts_ls' or client.name == 'basedpyright' then
            -- return false
            -- end
            -- return true
            -- end
        })
    end
})

-- Keymaps для диагностики
-- vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
