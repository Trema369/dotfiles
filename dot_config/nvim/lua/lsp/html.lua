-- ~/.config/nvim/lua/lsp/html.lua (optional)
local M = {}

M.setup = function()
  local lspconfig = require("lspconfig")

  -- optional: enable snippet support
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.html.setup({
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "razor" },
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(".git", "index.html"),
  })
end

return M
