return {
  "mason-org/mason-lspconfig.nvim",
  opts = {

    ensure_installed = {
      "pyright",
      "rust_analyzer",

    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
