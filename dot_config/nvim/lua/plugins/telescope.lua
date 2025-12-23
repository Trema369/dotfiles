return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
      end

      telescope.setup({

        extensions = {
          fzf = {},
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["i"] = {                        -- INSERT mode mappings
                ["<C-a>"] = fb_actions.create, -- create file / dir
                ["<C-d>"] = fb_actions.remove, -- delete file / dir
                ["<C-r>"] = fb_actions.rename, -- rename
                ["<C-c>"] = fb_actions.copy,   -- copy
                ["<C-m>"] = fb_actions.move,   -- move
                ["<C-h>"] = fb_actions.goto_parent_dir,
              },
              ["n"] = {                    -- NORMAL mode mappings
                ["a"] = fb_actions.create, -- add file / directory
                ["d"] = fb_actions.remove, -- delete
                ["r"] = fb_actions.rename, -- rename
                ["c"] = fb_actions.copy,   -- copy
                ["m"] = fb_actions.move,   -- move
                ["h"] = fb_actions.goto_parent_dir,
                ["l"] = require("telescope.actions").select_default,
              },
            }
          },
        },
      })

      -- load fzf extension AFTER setup
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      -- keymaps
      vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags)
      vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<space>fd", function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end)
      vim.keymap.set("n", "<space>fb", function()
        local path = vim.fn.expand("%:p:h")

        require("telescope").extensions.file_browser.file_browser({
          path = path,
          cwd = path,
          select_buffer = true,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 }
        })
      end)
    end,
  },
}
