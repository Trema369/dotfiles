require("config.lazy")
require("config.mappings")
require("tools")
require("ui.statusline")
require("config.tabline")
-- core editor options only
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "getline(v:foldstart).'...'.trim(getline(v:foldend))"
vim.opt.fillchars = { fold = "\\" }

vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.fillchars = vim.opt.fillchars + { eob = " " }
vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64" })

-- filetypes only (lightweight rules)
vim.filetype.add({
  extension = {
    xaml = "xml",
    axaml = "xml",
    tsx = "typescriptreact",
    jsx = "javascriptreact",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.axaml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "xml", "axaml" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.smartindent = false
    vim.bo.cindent = false
  end,
})
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
