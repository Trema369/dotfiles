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
        show_on_insert = false,
        show_on_backspace = false,
        prefetch_on_insert = false,
      },
      ghost_text = {
        enabled = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        treesitter_highlighting = false,

      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      menu = {
        border = "none",
        min_width = 20,
        max_height = 10,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
        draw = {
          gap = 1,
          padding = { 1, 1 },
          columns = {
            { "kind_icon", gap = 1 },
            { "label",     "label_description", gap = 1 },
            { "kind" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              width = { fixed = 2 },
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            label = {
              width = { fill = true, max = 35 },
              highlight = function(ctx)
                local highlights = {}
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end
                return highlights
              end,
            },
            label_description = {
              width = { max = 20 },
              highlight = "BlinkCmpLabelDescription",
            },
            kind = {
              width = { max = 12 },
              text = function(ctx) return "  " .. ctx.kind end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          elseif cmp.is_ghost_text_visible() then
            return cmp.accept()
          else
            return cmp.select_next()
          end
        end,
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
      window = {
        border = "none",
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      },
    },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    local C = {
      bg       = "#1e1e2e",
      bg_dark  = "#181825",
      bg_light = "#313244",
      surface0 = "#313244",
      surface1 = "#45475a",
      surface2 = "#585b70",
      text     = "#cdd6f4",
      subtext0 = "#a6adc8",
      subtext1 = "#bac2de",
      red      = "#f38ba8",
      green    = "#a6e3a1",
      blue     = "#89b4fa",
      sapphire = "#74c7ec",
      mauve    = "#cba6f7",
      peach    = "#fab387",
      yellow   = "#f9e2af",
      teal     = "#94e2d5",
    }

    -- menu — seamless dark panel, no border
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = C.bg_dark, bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = C.surface0, bold = true })

    -- labels
    vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = C.text, bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = C.blue, bg = C.bg_dark, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = C.subtext0, bg = C.bg_dark, italic = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = C.surface2, bg = C.bg_dark, strikethrough = true })

    -- documentation — slightly different shade for visual separation
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = C.bg_dark, bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = C.surface0 })
    vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = C.surface1, bg = C.bg_dark })

    -- signature help — mauve tinted to distinguish from docs
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = C.bg_dark, bg = C.bg_dark })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = C.peach, bold = true, underline = true })

    -- ghost text — barely visible, feels native
    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = C.surface2, italic = true })
  end,
}
