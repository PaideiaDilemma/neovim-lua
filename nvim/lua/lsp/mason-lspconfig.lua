-----------------------------------------------------------
-- Mason configuration file
-----------------------------------------------------------

-- Plugin: mason, mason-lspconfig
--[[ url: https://github.com/williamboman/mason.nvim
          https://github.com/williamboman/mason-lspconfig.nvim
--]]

local servers = require('lsp.servers')

local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
  return
end

mason.setup {
 ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "",
      package_uninstalled = "➜",
    },
  },
}


local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then
  return
end

mason_lspconfig.setup {
  ensure_installed = servers.names,
}

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      on_attach = require("lsp.handlers").on_attach,
      capabilities = require("lsp.handlers").capabilities,
    }

    opts = vim.tbl_deep_extend("force", servers.configs[server_name], opts)
    lspconfig[server_name].setup(opts)
  end
}
