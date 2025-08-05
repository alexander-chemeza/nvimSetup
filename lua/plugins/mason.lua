require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    check_outdated_packages_on_open = true,
  },
  max_concurrent_installers = 4,
})

-- Установка LSP-серверов
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",       -- Lua
    "vimls",        -- Vimscript
    "marksman",     -- Markdown
    "html",         -- HTML
    "cssls",        -- CSS
    "tailwindcss",  -- Tailwind CSS
    "ts_ls",        -- TypeScript/JavaScript
    "eslint",       -- ESLint
    "dockerls",     -- Docker
    "yamlls",       -- YAML
    "basedpyright", -- Python (заменяем pyright на basedpyright)
    "angularls",    -- Angular
    "jsonls",       -- JSON
    "nginx_language_server", -- Nginx
  },
  automatic_installation = true,
})

-- Установка форматтеров и линтеров через Mason
local mason_registry = require("mason-registry")

local formatters = {
  "stylua",          -- Lua
  "prettierd",       -- JS/TS/HTML/CSS/JSON
  "black",           -- Python
  "autopep8",        -- Python (альтернатива black)
  "yamlfmt",         -- YAML
  "fixjson",         -- JSON
  "nginxbeautifier", -- Nginx
  "shfmt",           -- Bash
}

local linters = {
  "eslint_d",        -- JS/TS
  "pylint",          -- Python
  "yamllint",        -- YAML
  "markdownlint",    -- Markdown
  "hadolint",        -- Docker
  "shellcheck",      -- Bash
}

-- Установка всех инструментов
local function ensure_tools()
  for _, tool in ipairs(formatters) do
    if mason_registry.has_package(tool) and not mason_registry.is_installed(tool) then
      mason_registry.get_package(tool):install()
    end
  end

  for _, tool in ipairs(linters) do
    if mason_registry.has_package(tool) and not mason_registry.is_installed(tool) then
      mason_registry.get_package(tool):install()
    end
  end
end

-- Запуск при старте Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = ensure_tools,
  once = true,
})

-- Добавление Mason в PATH
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
