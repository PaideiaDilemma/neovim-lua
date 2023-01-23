-----------------------------------------------------------
-- Language server list
-----------------------------------------------------------

-- Key: Server name
-- Value: Config
-- Available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

local server_config = {
  bashls = {},
  --pyright = {},
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          flake8 = {
            enabled = true
          }
        }
      }
    }
  },

  clangd = {},

  tsserver = {},

  html = {
    cmd = {'vscode-html-languageserver', '--stdio'}
  },

  cssls = {
    cmd = {'vscode-css-languageserver', '--stdio'}
  },

  jsonls = {
    cmd = {'vscode-json-languageserver', '--stdio'}
  },

  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      }
    }
  }
}

local server_names = {}

for server_name, _ in pairs(server_config) do
  table.insert(server_names, server_name)
end

return {
  names = server_names,
  configs = server_config
}
