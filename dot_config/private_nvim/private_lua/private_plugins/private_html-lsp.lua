return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "html", "razor" },
        },
      },
      setup = {
        html = function(_, opts)
          require("lsp.html").setup()
          return true -- prevents lazy.nvim from applying default setup
        end,
      },
    },
  },
}
