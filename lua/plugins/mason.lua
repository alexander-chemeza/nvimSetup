-- require("mason").setup()

-- require("mason-lspconfig").setup({
-- 	ensure_installed = {
-- 		"lua_ls",
-- 		"vimls",
-- 		"marksman",
-- 		"html",
-- 		"cssls",
-- 		"tailwindcss",
-- 		"ts_ls",
-- 		"dockerls",
-- 		"yamlls",
-- 		"pyright",
-- 		"angularls",
-- 		"jsonls",
-- 		"jsonls",
-- 		"nginx_language_server",
-- 	},
-- })

require("mason").setup({
  -- Ensure we can install all needed packages
  ui = {
    check_outdated_packages_on_open = true,
  }
})

-- Install both LSP servers and formatters/linters
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
    "nginx_language_server",
  }
})

-- Install formatters and linters via Mason
local mason_registry = require("mason-registry")

local formatters = {
  "stylua",
  "rustfmt",
  "autopep8",
  "yamlfmt",
  "fixjson",
  "prettierd",
  "nginxbeautifier"
}

local linters = {
  "pylint",
  "hadolint",
  "yamllint",
  "markdownlint",
  "eslint_d"
}

-- Function to ensure installation
local function ensure_installed()
  for _, pkg in ipairs(formatters) do
    if mason_registry.has_package(pkg) and not mason_registry.is_installed(pkg) then
      mason_registry.get_package(pkg):install()
    end
  end
  
  for _, pkg in ipairs(linters) do
    if mason_registry.has_package(pkg) and not mason_registry.is_installed(pkg) then
      mason_registry.get_package(pkg):install()
    end
  end
end

-- Run on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = ensure_installed,
  once = true,
})

-- Configure PATH to include Mason binaries
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"