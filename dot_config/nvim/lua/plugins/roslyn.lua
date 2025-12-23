return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
      --  { "tris203/rzls.nvim", config = true, ft = { "razorc" } },
    },
    config = function()
      require("lsp.roslyn").setup()
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
