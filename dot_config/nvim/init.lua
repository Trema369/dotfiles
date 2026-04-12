require("config.lazy")
require("config.diagnostics")
require("config.tabline")
require("config.theme")
require("config.player")
require("config.staline")
require("config.whichkey")
require("config.mappings")
require("lsp.roslyn")
require("lsp.ts")
require("lsp.avalonia-lsp")
require("config.toggleterm")
require("lsp.glslx")
require("config.filetypes")
require("config.neoscroll")
require("config.utilities")
require("snippets")
vim.opt.clipboard = "unnamedplus"
-- Line numbers and sign column

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64" })

-- Background of empty space in bufferline

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
-- Enable Tree-sitter based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Custom fold text:
-- shows first line ... last line
vim.opt.foldtext = "getline(v:foldstart).'...'.trim(getline(v:foldend))"

-- Remove ugly dots in folds
vim.opt.fillchars = { fold = "\\" }

-- Folding limits
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1

-- Start unfolded (recommended)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- Make bufferline fully transparent

vim.opt.fillchars = vim.opt.fillchars + { eob = " " }
vim.filetype.add({
  extension = {
    xaml = "xml",
    axaml = "xml",
  },
})

-- Treat .axaml files as XML for vim-xml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.axaml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "xml", "axaml" }, -- apply to both XML and Avalonia XAML
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    -- Use spaces and set indentation width
    vim.bo.expandtab = true -- use spaces instead of tabs
    vim.bo.shiftwidth = 4   -- spaces per indent level
    vim.bo.tabstop = 4      -- width of a tab character
    vim.bo.softtabstop = 4  -- insert/delete as 2 spaces

    -- Keep simple autoindent
    vim.bo.autoindent = true
    vim.bo.smartindent = false
    vim.bo.cindent = false
  end,
})
vim.cmd([[
  autocmd FileType xml,html,xaml,axaml setlocal shiftwidth=4 softtabstop=4 expandtab
]])
vim.filetype.add({
  extension = {
    tsx = "typescriptreact",
    jsx = "javascriptreact",
  },
})
