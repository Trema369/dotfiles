local M = {}

function M.setup()
  -- Get colors from your current theme
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  local float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })

  local bg = normal.bg or "#1e1e2e"
  local bg_dark = "#181825"
  local bg_light = "#313244"

  -- Base
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = bg, fg = bg })

  -- Prompt (top bar)
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = bg_light })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = bg_light, fg = bg_light })

  -- Results
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg })

  -- Preview (slightly darker = separation)
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg_dark })

  -- Selection highlight
  vim.api.nvim_set_hl(0, "TelescopeSelection", {
    bg = "#45475a",
    bold = true,
  })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "#313244", fg = "#313244" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "#1e1e2e", fg = "#1e1e2e" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "#181825", fg = "#181825" })
end

return M
