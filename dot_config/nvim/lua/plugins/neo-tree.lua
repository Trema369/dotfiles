return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    lazy = false,

    config = function()
      require("neo-tree").setup {
        close_if_last_window = true,

        enable_git_status = false,
        enable_diagnostics = false,

        default_component_configs = {
          indent = {
            with_expanders = false,
            with_markers = false,
            indent_size = 2,
          },

          icon = {
            folder_closed = "󰉋",
            folder_open = "󰝰",
            folder_empty = "󰜌",
          },

          name = {
            trailing_slash = false,
            use_git_status_colors = false,
          },

          git_status = {
            symbols = {},
          },
        },

        window = {
          width = 30,
        },

        filesystem = {
          follow_current_file = {
            enabled = true,
          },

          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      }

      -- Remove vertical split line
      vim.opt.fillchars:append {
        vert = " ",
      }
      local colors = require("kanagawa.colors").setup()

      vim.api.nvim_set_hl(0, "NeoTreeNormal", {
        bg = colors.palette.sumiInk0,
      })

      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", {
        bg = colors.palette.sumiInk0,
      })

      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", {
        bg = colors.palette.sumiInk0,
      })

      -- Transparent Neo-tree
      vim.keymap.set("n", "<C-n>", ":Neotree toggle filesystem left<CR>", { silent = true })
    end,
  },
}
