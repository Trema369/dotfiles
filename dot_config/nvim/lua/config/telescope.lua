local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  -- Optional extensions (safe loading)
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "file_browser")

  telescope.setup({
    defaults = {
      prompt_prefix = "   ", -- NvChad uses a nerd-font search icon
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    pickers = {
      find_files = {
        results_title = false, -- hides it
      },
      live_grep = {
        results_title = false,
      },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
        hidden = true,
        grouped = true,
        initial_mode = "normal", -- vim motions work immediately
        previewer = false,
        prompt_path = true, -- shows current path in prompt
        mappings = {
          ["n"] = {
            ["a"] = require("telescope._extensions.file_browser.actions").create,
            ["r"] = require("telescope._extensions.file_browser.actions").rename,
            ["d"] = require("telescope._extensions.file_browser.actions").remove,
            ["m"] = require("telescope._extensions.file_browser.actions").move,
            ["c"] = require("telescope._extensions.file_browser.actions").copy,
            ["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert") -- jump to insert to search
            end,
          },
        },
      },
    },
  })
  --  })

  local C = {
    bg = "#1e1e2e",
    bg_dark = "#181825",
    bg_light = "#313244",

    red = "#f38ba8",
    green = "#a6e3a1",
    blue = "#89b4fa",
    white = "#cdd6f4",
  }

  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = C.bg })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = C.bg_light })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = C.bg })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = C.bg_dark })

  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = C.red, bg = C.bg_light })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = C.bg_light, fg = C.white })

  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = C.bg, bg = C.blue })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = C.bg, bg = C.bg })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = C.bg, bg = C.green })
end

return M
