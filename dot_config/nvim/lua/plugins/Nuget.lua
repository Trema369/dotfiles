return {
  -- Nuget.nvim (Search and Install via Telescope)
  {
    "d7omdev/nuget.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- Load only when you use the keymaps
    keys = {
      { "<leader>ni", desc = "NuGet Install" },
      { "<leader>nr", desc = "NuGet Remove" },
    },
    config = function()
      require("nuget").setup({
        keys = {
          install = { "n", "<leader>ni" },
          remove = { "n", "<leader>nr" },
        },
      })
    end,
  },

  -- NeoNuGet (Management UI)
  {
    "MonsieurTib/neonuget",
    -- Load only for C# files or if you trigger the command
    ft = "cs",
    cmd = "NeoNuGet",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neonuget").setup({
        dotnet_path = "dotnet",
        default_project = nil,
      })
    end,
  },
}
