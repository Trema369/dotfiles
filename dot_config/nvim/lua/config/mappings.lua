-- mappings.lua
require("config.toggleterm")

-- Disable arrow keys
local opts = { noremap = true, silent = true }

local builtin = require("telescope.builtin")
-- Normal mode
vim.keymap.set("n", "<Up>", "<Nop>", opts)
vim.keymap.set("n", "<Down>", "<Nop>", opts)
vim.keymap.set("n", "<Left>", "<Nop>", opts)
vim.keymap.set("n", "<Right>", "<Nop>", opts)
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "diagnostics" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "file browser" })

-- Insert mode
vim.keymap.set("i", "<Up>", "<Nop>", opts)
vim.keymap.set("i", "<Down>", "<Nop>", opts)
vim.keymap.set("i", "<Left>", "<Nop>", opts)
vim.keymap.set("i", "<Right>", "<Nop>", opts)

-- Visual mode
vim.keymap.set("v", "<Up>", "<Nop>", opts)
vim.keymap.set("v", "<Down>", "<Nop>", opts)
vim.keymap.set("v", "<Left>", "<Nop>", opts)
vim.keymap.set("v", "<Right>", "<Nop>", opts)
vim.keymap.set({ "n", "v" }, "<C-S-f>", function()
  require("plugins.conform").format()
end, {
  desc = "Format",
})
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- jj to escape insert mode
vim.keymap.set("i", "jj", "<Esc>", opts)
