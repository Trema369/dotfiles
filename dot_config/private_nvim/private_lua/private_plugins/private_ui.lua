return {
  -- THEMES: Only the one you actually use stays eager
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = { treesitter = true, native_lsp = { enabled = true }, mini = true },
      })
      vim.cmd.colorscheme("tokyodark")
      require("config.highlights").setup()
    end,
  },
  { "folke/tokyonight.nvim", lazy = true }, -- Set others to lazy
  { "sainnhe/sonokai",       lazy = true },
  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    opts = {
      transparent_background = true,
      gamma = 1.00,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        identifiers = { italic = false },
        functions = {},
        variables = {}
      }
    },
    config = function(_, opts)
      require("tokyodark").setup(opts)
    end
  },

  -- ICONS: Load only when a UI component needs them
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual", -- "background" | "foreground" | "virtual"

        enable_hex = true,
        enable_rgb = true,
        enable_hsl = true,
        enable_var_usage = true, -- CSS variables
        enable_named_colors = true,

        --- Tailwind support
        enable_tailwind = true,

        --- style
        background = "dark", -- "dark" | "light
        virtual_symbol = " 󱓻 ",
        --- performance
        debounce = 200,
      })
    end,
  }
}
