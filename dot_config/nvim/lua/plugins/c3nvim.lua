return {
  "ManuLinares/nvim-c3",
  ft = "c3",
  config = function()
    require("c3").setup {
      lsp = {
        enable = false,
        cmd = "c3lsp",
      },
      formatter = {
        enable = true,
        cmd = "c3fmt",
        format_on_save = true,
      },
      highlighting = {
        enable_treesitter = true,
      },
    }
  end,
}

