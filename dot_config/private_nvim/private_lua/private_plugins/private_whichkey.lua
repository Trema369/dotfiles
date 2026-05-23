return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      config = function()
        require("which-key").setup({
          defaults = {
            preset = 'helix',
          }
        })
      end
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
