return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  -- This is the key to performance:
  -- The plugin only loads when you press one of these
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    -- This now only runs when you first trigger Telescope
    require("config.telescope").setup()
  end,
}

