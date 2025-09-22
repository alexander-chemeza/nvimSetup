local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()
local util = require("lspconfig.util")

vim.lsp.config('basedpyright', {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace"
            }
        }
    }
})

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            telemetry = { enable = false }
        }
    }
})

vim.lsp.config('emmet_ls', {
    capabilities = capabilities,
    filetypes = {
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "xml",
        "xsl",
        "pug",
        "sass",
        "scss",
        "less"
    },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            }
        }
    }
})

vim.lsp.config('eslint', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
    end
})

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end,
    root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
})

vim.lsp.config('yamlls', {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*'
            }
        }
    }
})

vim.lsp.config('jsonls', {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true }
        }
    }
})

vim.lsp.enable('basedpyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('ts_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('jsonls')

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.lua', '*.js', '*.ts', '*.json', '*.yaml', '*.html', '*.css' },
    callback = function()
        vim.lsp.buf.format({
            async = false,
            filter = function(client)
                return client.name ~= "basedpyright" and client.name ~= "ts_ls"
            end,
        })
    end
})

local function setup_python()
    local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
    if python_path and python_path ~= "" then
        vim.g.python3_host_prog = python_path
    end
end
setup_python()
