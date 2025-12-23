require("config.lazy")
require("config.lualine")
require("config.whichkey")
require("config.mappings")
require("lsp.avalonia-lsp")
require("config.conform")
-- require("lsp.blazor")




vim.opt.clipboard = "unnamedplus"









-- Line numbers and sign column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.fillchars = vim.opt.fillchars + { eob = " " }
vim.filetype.add({
  extension = {
    xaml = "xml",
    axaml = "xml",
  },
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
  autocmd FileType xml,html,xaml,axaml setlocal shiftwidth=2 softtabstop=2 expandtab
]])
