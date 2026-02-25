vim.o.showtabline = 2

-- Transparent background + white filename
vim.cmd("highlight TabLineFill guibg=NONE")
vim.cmd("highlight TabLine guibg=NONE guifg=white")

function _G.CenteredTabline()
  local filename = vim.fn.expand("%:t")
  if filename == "" then
    filename = "[No Name]"
  end

  local devicons = require("nvim-web-devicons")
  local icon, icon_hl = devicons.get_icon(filename, nil, { default = true })

  local display = ""

  if icon and icon_hl then
    -- %#[HLGROUP]# applies highlight
    display = "%#" .. icon_hl .. "#" .. icon .. "%* " .. filename
  else
    display = filename
  end

  local width = vim.o.columns
  local len = vim.fn.strdisplaywidth(filename) + 2
  local padding = math.floor((width - len) / 2)

  return string.rep(" ", padding) .. display
end

vim.o.tabline = "%!v:lua.CenteredTabline()"
vim.api.nvim_set_hl(0, "TabLine", { fg = "#ffffff", bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#ffffff", bg = "NONE" })
