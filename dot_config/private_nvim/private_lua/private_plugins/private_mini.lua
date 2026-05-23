return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("mini.icons").setup()

      require("mini.pairs").setup({})
    end,
  },
}
