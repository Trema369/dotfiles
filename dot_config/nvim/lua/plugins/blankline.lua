return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  main = "ibl",
  opts = {
    indent = {
      char = "▏",
      highlight = "IblIndent",
    },
    scope = {
      enabled = true,
      char = "▏",
      highlight = "IblScope", -- different color for current scope
      show_start = false,     -- no bracket at top
      show_end = false,       -- no bracket at bottom
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    -- Catppuccin Mocha colors
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#313244" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
  end,
}
