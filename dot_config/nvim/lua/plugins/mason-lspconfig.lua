return {
  "mason-org/mason-lspconfig.nvim",
  opts = {

    ensure_installed = {
      "pyright",
      "rust_analyzer",
      "eslint",
      "ts_ls",
      "jsonls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
