-- mappings.lua

-- Disable arrow keys
local opts = { noremap = true, silent = true }

-- Normal mode
vim.keymap.set('n', '<Up>', '<Nop>', opts)
vim.keymap.set('n', '<Down>', '<Nop>', opts)
vim.keymap.set('n', '<Left>', '<Nop>', opts)
vim.keymap.set('n', '<Right>', '<Nop>', opts)

-- Insert mode
vim.keymap.set('i', '<Up>', '<Nop>', opts)
vim.keymap.set('i', '<Down>', '<Nop>', opts)
vim.keymap.set('i', '<Left>', '<Nop>', opts)
vim.keymap.set('i', '<Right>', '<Nop>', opts)

-- Visual mode
vim.keymap.set('v', '<Up>', '<Nop>', opts)
vim.keymap.set('v', '<Down>', '<Nop>', opts)
vim.keymap.set('v', '<Left>', '<Nop>', opts)
vim.keymap.set('v', '<Right>', '<Nop>', opts)
vim.keymap.set({ "n", "v" }, "<C-S-f>", function()
  require("plugins.conform").format()
end, {
  desc = "Format",
})

-- jj to escape insert mode
vim.keymap.set('i', 'jj', '<Esc>', opts)
