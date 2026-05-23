return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- ONLY load when opening a markdown file
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
