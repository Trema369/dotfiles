vim.o.showtabline = 2

function \_G.CenteredTabline()
local filename = vim.fn.expand("%:t")
if filename == "" then
filename = "[No Name]"
end

local width = vim.o.columns
local len = vim.fn.strdisplaywidth(filename)
local padding = math.floor((width - len) / 2)

return string.rep(" ", padding) .. filename
end

vim.o.tabline = "%!v:lua.CenteredTabline()"
-- Make tabline background transparent and text white
vim.api.nvim_set_hl(0, "TabLine", { fg = "#ffffff", bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#ffffff", bg = "NONE" })
