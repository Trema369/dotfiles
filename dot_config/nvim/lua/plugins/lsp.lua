return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "saghen/blink.cmp",

      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    event = { "BufReadPre", "BufNewFile" },

    config = function()
      require("lsp.setup")
    end,
  },
}
