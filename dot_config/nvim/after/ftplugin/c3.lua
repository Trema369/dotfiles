local set = vim.opt_local

-- Indentation
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
vim.bo.cindent = true
vim.bo.cinkeys = "0{,0},0),0],:,!^F,o,O,e"
set.expandtab = true
