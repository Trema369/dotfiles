return {
  -- Noice for command line & messages
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup",
        opts = {}, -- global options for the cmdline. See section on views
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline_input", icon = "󰥻 " },
        },
      },
      messages = { enabled = true },
      popupmenu = { enabled = true, backend = "nui" },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- Snacks for extra UI & QoL
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      indent = {
        enabled = false,
        use_treesitter = true,
        fallback = true,
      },
      input = { enabled = true }, -- improved vim.ui.input
      notifier = {
        enabled = false,
        style = "fancy",
      }, -- notifications
      -- You can enable other modules here if you like:
      -- dashboard = { enabled = true },
      -- picker = { enabled = true },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },
}
