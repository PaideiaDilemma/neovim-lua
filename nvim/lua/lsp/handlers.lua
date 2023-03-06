-----------------------------------------------------------
-- Handlers for setting up lsp related things
-----------------------------------------------------------

local M = {}
local keymap = vim.keymap.set

local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.offsetEncoding = { "utf-16" }
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.setup = function()
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local config = {
    -- Enable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local buf_opts = { noremap=true, silent=true, buffer=bufnr }
    keymap('n', 'ge', vim.lsp.buf.declaration, buf_opts)
    keymap('n', 'gd', vim.lsp.buf.definition, buf_opts)
    keymap('n', 'K', vim.lsp.buf.hover, buf_opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, buf_opts)
    keymap('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)
    keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, buf_opts)
    keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, buf_opts)
    keymap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, buf_opts)
    keymap('n', 'gt', vim.lsp.buf.type_definition, buf_opts)
    keymap('n', '<space>rn', vim.lsp.buf.rename, buf_opts)
    keymap('n', '<space>ca', vim.lsp.buf.code_action, buf_opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    keymap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, buf_opts)

    keymap('n', '<space>e', vim.diagnostic.open_float, buf_opts)
    keymap('n', '[d', vim.diagnostic.goto_prev, buf_opts)
    keymap('n', ']d', vim.diagnostic.goto_next, buf_opts)
    keymap('n', '<space>q', vim.diagnostic.setloclist, buf_opts)
end

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
end

return M
