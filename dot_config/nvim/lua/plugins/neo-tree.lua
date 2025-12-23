return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- for file icons
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree", -- lazy-load on command
    keys = {         -- optional keymap
      { "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- close Neo-tree if it's the last window
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          indent = { padding = 1 },
          icon = { folder_closed = "", folder_open = "" },
          git_status = { symbols = { added = "+", modified = "~", removed = "-" } },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        window = {
          width = 35,
          mappings = {
            ["a"] = "add", -- add a new file
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["<cr>"] = "open",
          },
        },
      })
    end,
  },
}
