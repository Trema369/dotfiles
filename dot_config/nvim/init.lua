vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.opt.clipboard = "unnamedplus"
-- 2. BOOTSTRAP LAZY
require "config.lazy"

-- 3. DEFER HEAVY UI (Statusline/Tabline)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require "tools"
    require "ui.statusline"
    require "config.tabline"
    require "config.mappings"
    require("lsp.setup").setup()
    -- Now enable clipboard after the UI is up
  end,
})

-- 4. CORE OPTIONS (Lightweight)
vim.opt.number = true
vim.opt.relativenumber = true
-- ... (rest of your vim.opt and autocmds)

vim.opt.fillchars = vim.opt.fillchars + { eob = " " }
vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64" })

-- filetypes only (lightweight rules)
vim.filetype.add {
  extension = {
    xaml = "xml",
    axaml = "xml",
    tsx = "typescriptreact",
    jsx = "javascriptreact",
    c3 = "c3",
    c3i = "c3i",
  },
}
vim.diagnostic.config {
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
}
