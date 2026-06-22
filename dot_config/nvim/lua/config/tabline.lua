function _G.CustomWinbar()
  -- Hide winbar in Neo-tree
  if vim.bo.filetype == "neo-tree" then
    return ""
  end

  local filename = vim.fn.expand "%:t"

  if filename == "" then
    filename = "[No Name]"
  end

  local devicons = require "nvim-web-devicons"
  local icon, icon_hl = devicons.get_icon(filename, nil, { default = true })

  local display

  if icon and icon_hl then
    display = "%#" .. icon_hl .. "#" .. icon .. "%* " .. filename
  else
    display = filename
  end

  -- Right-align
  return "%=" .. display .. " "
end

-- Enable winbar
vim.o.winbar = "%{%v:lua.CustomWinbar()%}"

-- Let Kanagawa handle colors naturally
vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
vim.api.nvim_set_hl(0, "WinBarNC", { link = "NormalNC" })
