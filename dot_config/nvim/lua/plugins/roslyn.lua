return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },

    dependencies = {
      -- { "tris203/rzls.nvim", config = true, ft = { "razorc" } },
    },

    config = function()
      vim.lsp.config("roslyn", require("lsp.roslyn"))
      vim.lsp.enable("roslyn")
    end,

    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
