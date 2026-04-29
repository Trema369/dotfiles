return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<F5>",    function() require("config.toggleterm").run_project() end,   desc = "Run Project" },
    { "<S-F10>", function() require("config.toggleterm").build_project() end, desc = "Build Project" },
    { [[<c-\>]], "<cmd>ToggleTerm<cr>",                                       desc = "Toggle Terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      direction = "float",
      open_mapping = [[<c-\>]],
    })
  end,
}
