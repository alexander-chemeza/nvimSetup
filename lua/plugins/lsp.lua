local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Common on_attach
local function on_attach(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- Helpers
local function fallback_root(files)
    return function(fname)
        local found = vim.fs.find(files, { path = fname and vim.fs.dirname(fname) or vim.loop.cwd(), upward = true })
        return found[1] and vim.fs.dirname(found[1]) or vim.loop.cwd()
    end
end

-- Servers
local servers = {
    {
        name = "lua_ls",
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_dir = fallback_root({ ".git", ".luarc.json" }),
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
            },
        },
    },
    {
        name = "emmet_ls",
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "xml", "xsl", "pug", "sass", "scss", "less" },
        root_dir = fallback_root({ ".git" }),
        init_options = { html = { options = { ["bem.enabled"] = true } } },
    },
    {
        name = "eslint",
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = fallback_root({ ".eslintrc.js", ".git" }),
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            on_attach(client, bufnr)
        end,
    },
    {
        name = "tsserver",
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = fallback_root({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
        end,
    },
    {
        name = "basedpyright",
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = fallback_root({ "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.codeActionProvider = {
                resolveProvider = true,
                codeActionKinds = { "quickfix", "refactor", "source.organizeImports" },
            }
            on_attach(client, bufnr)
        end,
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                },
            },
        },
    },
    {
        name = "yamlls",
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml" },
        root_dir = fallback_root({ ".git" }),
        settings = {
            yaml = {
                schemas = { ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*" },
            },
        },
    },
    {
        name = "jsonls",
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json" },
        root_dir = fallback_root({ ".git" }),
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
}

-- Start servers lazily (only when opening a matching filetype)
for _, config in ipairs(servers) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = config.filetypes or "*",
        callback = function(args)
            local final_config = vim.tbl_deep_extend("force", {
                on_attach = on_attach,
                capabilities = capabilities,
            }, config, { root_dir = config.root_dir(args.file) })
            vim.lsp.start(final_config)
        end,
    })
end

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.yaml", "*.html", "*.css" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

