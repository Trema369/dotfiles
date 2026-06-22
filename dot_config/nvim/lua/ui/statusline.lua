local M = {}

-- sync buffer background (run ONCE, not per statusline call)
local function sync_statusline_bg()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

  vim.api.nvim_set_hl(0, "StatusLine", {
    fg = normal.fg,
    bg = normal.bg,
  })

  vim.api.nvim_set_hl(0, "StatusLineNC", {
    fg = normal.fg,
    bg = normal.bg,
  })
end

sync_statusline_bg()

local function git_branch()
  local dict = vim.b.gitsigns_status_dict
  if not dict or not dict.head then
    return ""
  end
  return "  " .. dict.head .. " "
end

local function diagnostics()
  local counts = vim.diagnostic.count(0)

  local e = counts[vim.diagnostic.severity.ERROR] or 0
  local w = counts[vim.diagnostic.severity.WARN] or 0

  return (e > 0 and ("  " .. e) or "") .. " " .. (w > 0 and ("  " .. w) or "")
end

function _G.CustomStatusLine()
  local win = vim.g.statusline_winid
  if not win then
    return ""
  end

  local buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].filetype

  -- 🚫 HARD BLOCK Neo-tree
  if ft == "neo-tree" then
    return ""
  end

  return table.concat {
    "%#StatusLine#",
    git_branch(),
    "%=",
    diagnostics(),
    "%=",
    " ",
  }
end

vim.o.statusline = "%!v:lua.CustomStatusLine()"

return M
