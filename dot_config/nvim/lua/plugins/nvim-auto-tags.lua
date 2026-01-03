return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },

  -- Load only for relevant filetypes
  ft = {
    "html",
    "xml",
    "xaml",
    "axaml",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "handlebars",
    "vue",
  },

  -- Use config function to call setup directly and avoid legacy warning
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        -- Global defaults
        enable_close = true,           -- Auto-close tags
        enable_rename = true,          -- Auto-rename pairs
        enable_close_on_slash = false, -- Don't auto-close on trailing </
        aliases = {                    -- Treat XAML as XML
          axaml = "xml",
          xaml = "xml",
        },
      },
      -- Per-filetype overrides
      per_filetype = {
        html = { enable_close = true },
        xaml = { enable_close = true },
        axaml = { enable_close = true },
      },
    })
  end,
}
