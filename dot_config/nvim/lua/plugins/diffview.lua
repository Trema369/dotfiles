return {
  "esmuellert/vscode-diff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff", -- lazy-load only when :CodeDiff is called
  config = function()
    -- Setup with custom highlights
    require("vscode-diff").setup({})
    -- Keymap to open CodeDiff
  end,
}
