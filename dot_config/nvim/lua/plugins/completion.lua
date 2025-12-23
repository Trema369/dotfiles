return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = false } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },

      mapping = {
        -- Tab selects next completion if popup is visible
        ["<Tab>"] = function(fallback)
          local cmp = require("cmp")
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,

        -- Shift-Tab selects previous completion
        ["<S-Tab>"] = function(fallback)
          local cmp = require("cmp")
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
      },
    },
    opts_extend = { "sources.default" }
  }
}
