return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({
      --- how colors are shown
      render = "virtual", -- "background" | "foreground" | "virtual"

      --- enable color formats
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
