vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    -- Core statusline groups
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

    -- Force everything linked to them transparent
    vim.cmd("highlight clear Staline")
    vim.cmd("highlight clear StalineNC")

    vim.api.nvim_set_hl(0, "Staline", { bg = "none" })
    vim.api.nvim_set_hl(0, "StalineNC", { bg = "none" })
  end,
})
