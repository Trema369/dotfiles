return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  version = "1.*",
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    snippets = {
      preset = "luasnip",
    },
    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
      trigger = {
        --        debounce_ms = 150,
        show_on_insert = false,
        show_on_backspace = false,
        prefetch_on_insert = false,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        treesitter_highlighting = false,
        window = { border = "rounded" },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      menu = {
        border = "rounded",
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
      },
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp) return cmp.select_next() end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp) return cmp.select_prev() end,
        "snippet_backward",
        "fallback",
      },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
  },
}
